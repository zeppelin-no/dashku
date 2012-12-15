# Internals, where all the config is loaded and set into the application
ss = require 'socketstream'

app = 
  models      : {}
  controllers : {}
  schemas     : {}

app.config = require('./server/config')[ss.env]

require("#{__dirname}/server/db.coffee") app
require("#{__dirname}/server/mailer.coffee") app



ss.api.add 'app', app