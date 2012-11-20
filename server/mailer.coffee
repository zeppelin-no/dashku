nodemailer = require 'nodemailer'
config     = require './config'

# Setup the global mail transport
global.postman = nodemailer.createTransport config[ss.env].mail.type, config[ss.env].mail.options