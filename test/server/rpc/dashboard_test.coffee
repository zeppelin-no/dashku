assert = require 'assert'

describe "Dashboard", ->

  describe "#create", ->

    describe "if the name and userId is present", ->

      it "should create the dashboard, and return a success status along with the dashboard", (done) ->
        # Assume that we are already logged in from authentication.coffee
        ass.rpc "dashboard.create", {name: "Nice dashboard"}, (res) ->
          assert.equal res[0].status, "success"
          assert.equal res[0].dashboard.name, "Nice dashboard"
          done()

      it "should emit a dashboardCreated event with the dashboard"
      # TODO - find out how to listen on emitted events, I think
      # there's a gist somewhere for this

    describe "if the name is not present", ->

      it "should return a failure status", (done) ->
        ass.rpc "dashboard.create", {}, (res) ->
          assert.equal res[0].status, "failure"
          done()

      it "should explain what went wrong"
      # TODO - handle validation errors from object to string

  describe "#getAll", ->

    it "should return a success status & the user's dashboards", (done) ->
      ass.rpc "dashboard.getAll", (res) ->
        assert.equal    res[0].status, "success"
        assert.notEqual res[0].dashboards, undefined
        assert.equal    res[0].dashboards[0].name, "Nice dashboard"
        assert.equal    res[0].dashboards[res[0].dashboards.length-1].name, "Your Dashboard"
        done()

  describe "#externalGet", ->

    describe "if dashboard is found", ->

      it "should subscribe the user to their own private channel"
      # TODO - find a way to observe channel creation

      it "should return a success status and the dashboard", (done) ->
        Dashboard.findOne {}, (err, dashboard) ->
          ass.rpc "dashboard.externalGet", dashboard._id, (res) ->
            assert.equal res[0].status, "success"
            assert.equal res[0].dashboard.name, dashboard.name
            assert.equal res[0].dashboard._id, dashboard._id.toString()             
            done()        

    describe "if dashboard is not found", ->

      it "should return a failure status and explain what went wrong", (done) ->
        ass.rpc "dashboard.externalGet", "00001", (res) ->
          assert.equal res[0].status, "failure"
          assert.equal res[0].reason, "Dashboard not found"
          done()

  describe "#update", ->

    describe "if successful", ->

      it "should update the dashboard", (done) ->
        Dashboard.findOne {}, (err, dashboard) ->
          ass.rpc "dashboard.update", {_id: dashboard._id, name: "CheeseWin"}, (res) ->
            assert.equal res[0].status, "success"
            assert.equal res[0].dashboard.name, "CheeseWin"
            Dashboard.findOne {_id: dashboard._id}, (err, dashboardReloaded) ->
              assert.equal dashboardReloaded.name, "CheeseWin"
              done()

      it "should emit a dashboardUpdated event to the user's channel, with the updated dashboard"

    describe "if not successful, because the dashboard id does not exist", ->

      it "should return a failure status and explain what went wrong", (done) ->
        ass.rpc "dashboard.update", {_id: "000111", name: "Bonobo"}, (res) ->
          assert.equal res[0].status, "failure"
          assert.equal res[0].reason, "Dashboard not found"          
          done()

  describe "#delete", ->

    describe "if successful", ->

      it "should delete the dashboard, and return a success status along with the deleted dashboard's id", (done) ->
        Dashboard.findOne {}, (err, dashboard) ->
          ass.rpc "dashboard.delete", dashboard._id, (res) ->
            assert.equal res[0].status, "success"
            assert.equal res[0].dashboardId, dashboard._id.toString()
            Dashboard.findOne {_id: dashboard._id}, (err, dashboardReloaded) ->
              assert.equal dashboardReloaded, null
              done()

      it "should emit a dashboardDeleted event to the user's channel, with the id of the deleted dashboard"


    describe "if not successful because only one dashboard remains", ->

      it "should return a failure status and explain what went wrong", (done) ->
        Dashboard.findOne {}, (err, dashboard) ->
          ass.rpc "dashboard.delete", dashboard._id, (res) ->
            assert.equal res[0].status, "failure"
            assert.equal res[0].reason, "You can't delete your last dashboard"
            done()

    describe "if not successful because dashboard id does not exist", ->

      it "should return a failure status and explain what went wrong", (done) ->
        ass.rpc "dashboard.create", {name: "YA Dashboard"}, (err, dashboard) ->
          ass.rpc "dashboard.delete", "00001", (res) ->
            assert.equal res[0].status, "failure"
            assert.equal res[0].reason, "Dashboard not found"
            done()

  describe "#updateWidgetPositions", ->

    describe "if successful", ->
      
      it "should set the widget's position to the new value"

      it "should adjust the positions of the other widgets accordingly"

      it "should emit a widgetPositionsUpdated event to the user's channel, with the positions data"

      it "should return a success status"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"