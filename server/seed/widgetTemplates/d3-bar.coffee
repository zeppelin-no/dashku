module.exports =
  name: 'D3 Bar'
  snapshotUrl: "/images/widgetTemplates/d3Bar.png"

fs          = require 'fs'
name        = "D3 Bar"
html        = ""
css         = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/d3-bar/main.css"
script      = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/d3-bar/main.js"
json        = fs.readFileSync "#{__dirname}/../widgetTemplateFiles/d3-bar/main.json"
snapshotUrl = "/images/widgetTemplates/d3Bar.png"

module.exports = {name, html, css, script, json, snapshotUrl}