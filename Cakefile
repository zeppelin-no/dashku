# Cakefile

loadDependencies = ->
  env                       = process.env["SS_ENV"] || "development"
  fs                        = require 'fs'

# If you move to a new Redis DB, you may want to run this function
# to regenerate the API Key database
regenerateApiKeyDb = ->
  loadDependencies()
  User.find {}, (err, docs) ->
    if !err
      for doc in docs
        console.log "we did this"
        Redis.hset "apiKeys", doc.apiKey, doc._id, redis.print

# This populates the WidgetTemplates collection with Widget Templates
populateWidgetTemplates = ->
  loadDependencies()
  console.log "Clearing the WidgetTemplates collection"
  WidgetTemplate.remove {}, (err) ->
    if !err
      fs.readdir "#{__dirname}/server/seed/widgetTemplates/", (err, files) ->
        if !err and files
          count = 0
          for file in files
            widgetTemplate = new WidgetTemplate require "#{__dirname}/server/seed/widgetTemplates/#{file}"
            widgetTemplate.save (err,doc) -> 
              count++
              msg = if !err then "WidgetTemplate collection populated" else "There was an error populating the WidgetTemplate collection"
              console.log msg
              process.exit 0 if count is files.length-1
    else
      console.log "There was an error clearing the WidgetTemplates collection"
      process.exit 1

# TODO - figure out a way to automate this
files = [
  "server/models/user.coffee"
  "server/rpc/authentication.coffee"
  "server/rpc/dashboard.coffee"
  "server/rpc/general.coffee"
  "server/rpc/widget.coffee"
  "server/rpc/widgetTemplate.coffee"
]

test = (callback) ->
  mocha                 = require 'mocha'
  process.env["SS_ENV"] = "test"
  loadDependencies()
  Mocha = new mocha
  for file in files
    Mocha.addFile "test/#{file.replace('.coffee','_test.coffee')}"
  Mocha.run ->
    callback() if callback?

task 'test', 'run unit tests for the project', ->
  test process.exit

task 'regenerateApiKeyDb', 'Compiles the SocketStream assets, and copies them to a fixed path', ->
  regenerateApiKeyDb()

task 'populateWidgetTemplates', "Populates the database with widget templates", ->
  populateWidgetTemplates()

