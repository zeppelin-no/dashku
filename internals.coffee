# Internals, where all the config is loaded and set into the application
ss = require 'socketstream'

app = 
  models      : {}
  controllers : {}
  schemas     : {}

app.config = require('./server/config')[ss.env]

require("#{__dirname}/server/db.coffee") app
require("#{__dirname}/server/mailer.coffee") app

require("#{__dirname}/server/controllers/dashboard.coffee") app

ss.api.add 'app', app

#### HELPERS ####

# This fetches the user from the session
ss.api.add 'fetchUserFromSession', (req, res, next) ->
  ss.api.app.models.User.findOne {_id: req.session.userId}, (err, user) ->
    if !err and user?
      next user
    else
      res status: 'failure', reason: err || "User not found"