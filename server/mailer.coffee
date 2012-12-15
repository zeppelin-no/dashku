nodemailer = require 'nodemailer'

module.exports = (app) ->

  # Setup the global mail transport
  app.postman = nodemailer.createTransport app.config.mail.type, app.config.mail.options