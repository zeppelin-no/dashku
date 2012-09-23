describe "Dashboard", ->

  describe "#create", ->

    describe "if the name and userId is present", ->

      it "should create the dashboard"

      it "should emit a dashboardCreated event with the dashboard"

      it "should return a success status, and the dashboard"

    describe "if the name is not present", ->

      it "should return a failure status"

      it "should explain what went wrong"

  describe "#getAll", ->

    it "should return a success status & the user's dashboards"

    it "should return the user's dashboards in alphabetical order"

  describe "#externalGet", ->

    describe "if dashboard is found", ->

      it "should subscribe the user to their own private channel"

      it "should return a success status and the dashboard"

    describe "if dashboard is not found", ->

      it "should return a failure status"

      it "should explain what went wrong"

  describe "#update", ->

    describe "if successful", ->

      it "should update the dashboard"

      it "should emit a dashboardUpdated event to the user's channel, with the updated dashboard"

      it "should return a success status, and the updated dashboard"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"

  describe "#delete", ->

    describe "if successful", ->

      it "should delete the dashboard"

      it "should emit a dashboardDeleted event to the user's channel, with the id of the deleted dashboard"

      it "should return a success status"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"

  describe "#updateWidgetPositions", ->

    describe "if successful", ->
      
      it "should set the widget's position to the new value"

      it "should adjust the positions of the other widgets accordingly"

      it "should emit a widgetPositionsUpdated event to the user's channel, with the positions data"

      it "should return a success status"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"