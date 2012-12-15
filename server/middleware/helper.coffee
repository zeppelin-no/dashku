#### HELPERS ####
ss = require 'socketstream'

# This fetches the user from the session
global.fetchUserFromSession = (req, res, next) ->

  ss.api.app.models.User.findOne {_id: req.session.userId}, (err, user) ->
    if !err and user?
      next user
    else
      res status: 'failure', reason: err || "User not found"