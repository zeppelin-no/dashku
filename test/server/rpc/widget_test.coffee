assert = require 'assert'

describe "Widget", ->
  
  describe "#create", ->

    describe "if successful", ->

      it "should create a widget in the dashboard", (done) ->
        Dashboard.findOne {}, (err, dashboard) ->
          ass.rpc 'widget.create', {name: "Sales Widget", dashboardId: dashboard._id}, (res) ->
            assert.equal res[0].status, "success"
            assert.equal res[0].widget.name, "Sales Widget"
            Dashboard.findOne {_id: dashboard._id}, (err, dashboardReloaded) ->
              assert.equal dashboardReloaded.widgets[dashboardReloaded.widgets.length-1].name, "Sales Widget"
              done()

      it "should scope the widget's css", (done) ->
        Dashboard.findOne {}, (err, dashboard) ->
          css = ".content { background: blue; }"
          ass.rpc 'widget.create', {name: "Sales Widget", dashboardId: dashboard._id, css: css}, (res) ->
            assert.equal res[0].status, "success"
            assert.equal res[0].widget.scopedCSS, ".widget[data-id='" + res[0].widget._id + "'] .content { background: blue; }"
            done()

      it "should append the widget id and the api key to the JSON"
      # we want to save some example json, 
      # and parse it to check it has the user's API key, 
      # and the widget's id
      #

      it "should emit a widgetCreated event to the user's channel, with the dashboard id, and the widget"

    describe "if not successful", ->

      it "should return a failure status and explain what went wrong", (done) ->
        ass.rpc 'widget.create', {name: "Finance Widget", dashboardId: "231312312"}, (res) ->
          assert.equal res[0].status, "failure"
          assert.equal res[0].reason, "dashboard with id 231312312 not found"
          done()

  describe "#update", ->

    describe "if successful", ->

      it "should update the widget with the new attributes"

      it "should append the widget id and the api key to the new JSON"

      it "should scope the widget's css"

      it "should update the updatedAt attribute"

      it "should emit the widgetUpdated event to the user's channel, with the dashboard id, and the widget"

      it "should return a success status, and the widget"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"

  describe "#delete", ->

    describe "if successful", ->

      it "should remove the widget from the dashboard"

      it "should emit the widgetDeleted event to the user's channel, with the dashboard id, and the widget id"

      it "should return a success status with the widget id"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"
