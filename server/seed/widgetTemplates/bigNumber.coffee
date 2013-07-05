fs          = require 'fs'
name        = "Big Number"
html        = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/bigNumber/main.html"
css         = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/bigNumber/main.css"
script      = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/bigNumber/main.js"
json        = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/bigNumber/main.json"
snapshotUrl = "/images/widgetTemplates/bigNumber.png"

module.exports = {name, html, css, script, json, snapshotUrl}