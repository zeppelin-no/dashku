describe "Widget", ->
  
  describe "#create", ->

    describe "if successful", ->

      it "should create a widget in the dashboard"

      it "should scope the widget's css"

      it "should append the widget id and the api key to the JSON"

      it "should emit a widgetCreated event to the user's channel, with the dashboard id, and the widget"

      it "should return a success status, and the widget"

    describe "if not successful", ->

      it "should return a failure status"

      it "should explain what went wrong"

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
