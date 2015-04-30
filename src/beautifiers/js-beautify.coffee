"use strict"
Beautifier = require('./beautifier')

module.exports = class JSBeautify extends Beautifier

    options: {
        HTML: true
        Handlebars: true
        Mustache: true
        Marko: true
        JavaScript: true
        JSON: true
        CSS: true
    }

    beautify: (text, language, options) ->

        return new @Promise((resolve, reject) ->
            try
                switch language
                    when "JSON", "JavaScript"
                      beautifyJS = require("js-beautify")
                      text = beautifyJS(text, options)
                      resolve text
                    when "Handlebars", "Mustache"
                      # jshint ignore: start
                      options.indent_handlebars = true # Force jsbeautify to indent_handlebars
                      # jshint ignore: end
                      beautifyHTML = require("js-beautify").html
                      text = beautifyHTML(text, options)
                      resolve text
                    when "HTML (Liquid)", "HTML", "XML", "Marko", "Web Form/Control (C#)", "Web Handler (C#)"
                      beautifyHTML = require("js-beautify").html
                      text = beautifyHTML(text, options)
                      resolve text
                    when "CSS"
                      beautifyCSS = require("js-beautify").css
                      text = beautifyCSS(text, options)
                      resolve text
            catch err
                reject(err)

        )