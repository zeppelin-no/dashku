assert  = require "assert"

describe "Authentication", ->
  
  before (done) ->
    User.remove {}, (err) ->
      Dashboard.remove {}, (err) ->
        done()

  describe "#signup", ->

    describe "if a valid request is made", ->

      before (done) ->

        @res = null

        newUserCredentials = 
          username: "paul" 
          email:    "paul@anephenix.com" 
          password: "123456"

        ass.rpc 'authentication.signup', newUserCredentials, (res) =>
          # For some reason, the res object called back is an array,
          # rather than the object that we get back in the browser
          #
          # See https://github.com/socketstream/socketstream/issues/278
          # for more information on this bug.
          #
          @res = res[0]
          done()

      it "should create a new user record", (done) ->
          User.count (err,count) ->
            assert.equal 1, count
            done()

      it "should append a new hash to the apiKeys set in Redis", (done) ->
        User.findOne {_id: @res.user._id}, (err, user) ->
          Redis.hget "apiKeys", user.apiKey, (err,val) ->
            assert.equal val, user._id
            done()

      it "should generate a dashboard for the new user", (done) ->
        Dashboard.findOne {userId: @res.user._id}, (err, dashboard) ->
          assert.equal dashboard.name, "Your Dashboard"
          done()

      it "should subscribe the user to their own private channel"
      # It would be nice if we could observe channels being 
      # created via pubsub. Find out how.

      it "should return a success response", (done) ->
        assert.equal @res.status, "success"
        done()

    describe "if the user already exists", ->

      before (done) ->

        @res = null 

        newUserCredentials = 
          username: "paul" 
          email:    "paul@anephenix.com" 
          password: "123456"

        ass.rpc 'authentication.signup', newUserCredentials, (res) =>
          @res = res[0]
          done()

      it "should not create another user", (done) ->
        User.count (err,count) ->
          assert.equal 1, count
          done()

      it "should return a failure response", (done) ->
        assert.equal @res.status, "failure"
        done()

    describe "if the user is missing some credentials", ->

      it "should return a failure response", (done) ->
        missingUsername = 
          email:    "earthworm@jim.com"
          password: "123456"

        missingEmail = 
          username: "earthwormJim"
          password: "123456"

        missingPassword = 
          username: "earthwormJim0"
          email:    "earthworm0@jim.com"

        ass.rpc 'authentication.signup', missingUsername, (res) ->
          assert.equal res[0].status, "failure"

          ass.rpc 'authentication.signup', missingEmail, (res) ->
            assert.equal res[0].status, "failure"

            ass.rpc 'authentication.signup', missingPassword, (res) ->
              assert.equal res[0].status, "failure"
              done()
