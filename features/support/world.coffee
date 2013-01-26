selenium              = require 'selenium-launcher'
soda                  = require 'soda'
process.env["SS_ENV"] = "cucumber"
ss                    = require 'socketstream'
config                = require '../../server/config.coffee'
app                   = require '../../app.coffee'

browser = null

World = (callback) ->
  
    if browser is null
      selenium (err, selenium) =>
 
        browser = soda.createClient
          host:     selenium.host
          port:     selenium.port
          url:      config[ss.env].apiHost
          browser:  "firefox"

        @browser  = browser
        callback {@browser}
        process.on 'exit', -> selenium.kill()
    else
      @browser  = browser
      callback {@browser}

exports.World = World

# *firefox
# *mock
# *firefoxproxy
# *pifirefox
# *chrome
# *iexploreproxy
# *iexplore
# *firefox3
# *safariproxy
# *googlechrome
# *konqueror
# *firefox2
# *safari
# *piiexplore
# *firefoxchrome
# *opera
# *webdriver
# *iehta
# *custom