module.exports = ->

  @World = require('../support/world').World

  @Given /^a user has created an account$/, (callback) ->
    callback.pending()

  @Given /^they have logged in$/, (callback) ->
    callback.pending()

  @When /^they click on the "([^"]*)" button$/, (arg1, callback) ->
    callback.pending()

  @Then /^they should see the "([^"]*)" modal$/, (arg1, callback) ->
    callback.pending()

  @When /^they fill in "([^"]*)" with "([^"]*)"$/, (arg1, arg2, callback) ->
    callback.pending()

  @When /^they press "([^"]*)"$/, (arg1, callback) ->
    callback.pending()

  @Then /^they should see "([^"]*)"$/, (arg1, callback) ->
    callback.pending()