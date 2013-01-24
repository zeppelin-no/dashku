# Internals, where all the config is loaded and set into the application
ss = require 'socketstream'

app = 
  models      : {}
  controllers : {}
  schemas     : {}
  helpers     : {}

app.config = require('./server/config')[ss.env]

require("#{__dirname}/server/db.coffee") app
require("#{__dirname}/server/helpers.coffee") app

require("#{__dirname}/server/controllers/dashboard.coffee") app
require("#{__dirname}/server/controllers/widget.coffee") app

ss.api.add 'app', app