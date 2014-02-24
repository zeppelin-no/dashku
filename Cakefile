# Cakefile

# This populates the WidgetTemplates collection with Widget Templates
populateWidgetTemplates = (cb) ->
  fs                    = require 'fs'
  ss                    = require 'socketstream'
  internals             = require './server/internals'
  WidgetTemplate        = ss.api.app.models.WidgetTemplate
  console.log "Clearing the WidgetTemplates collection"
  WidgetTemplate.remove {}, (err) ->
    if err is null
      fs.readdir "#{__dirname}/server/seed/widgetTemplates/", (err, files) ->
        if !err and files
          count = 0
          for file in files
            widgetTemplate = new WidgetTemplate require "#{__dirname}/server/seed/widgetTemplates/#{file}"
            widgetTemplate.save (err,doc) -> 
              count++
              if err? then console.log "There was an error populating the WidgetTemplate collection"
              if count is files.length-1
                console.log "WidgetTemplate collection populated"
                cb 0
    else
      console.log "There was an error clearing the WidgetTemplates collection"
      cb 1

task 'populateWidgetTemplates', "Populates the database with widget templates", ->
  populateWidgetTemplates process.exit