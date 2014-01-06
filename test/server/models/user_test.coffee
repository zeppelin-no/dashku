ss        = require "socketstream"
assert    = require "assert"
internals = require "../../../server/internals" 

User = ss.api.app.models.User

describe "User", ->

  describe "new", ->

    before (done) ->
      User.remove {}, (err) ->
        done()

    it "should encrypt the password", (done) ->
      userCredentials = 
        username: "paulbjensen"
        email:    "paul@anephenix.com"
        password: "123456"

      new User(userCredentials).save (err, doc) ->
        assert.equal doc.password         , undefined
        assert.notEqual doc.passwordHash  , undefined
        assert.notEqual doc.passwordSalt  , undefined
        done()

  describe "validations", ->

    describe "username", ->

      beforeEach (done) ->
        User.remove {}, (err) ->
          userCredentials = 
            username: "paulbjensen"
            email:    "paul@anephenix.com"
            password: "123456"
          new User(userCredentials).save (err, doc) ->
            assert.equal err, null
            done()      

      it "should be unique", (done) ->
          userCredentials = 
            username: "paulbjensen"
            email:    "bob@bob.com"
            password: "123456"

          new User(userCredentials).save (err, doc) ->
            assert.notEqual err, null
            User.count (err, count) ->
              assert.equal count, 1
              done()

      it "should be present", (done) ->
        userCredentials = 
          email: "ren@renandstimpy.com"
          password: "123456"

        new User(userCredentials).save (err, doc) ->
          assert.notEqual err, null
          done()

    describe "email", ->

      beforeEach (done) ->
        User.remove {}, (err) ->
          username  = "paulbjensen"
          email     = "paul@anephenix.com"
          password  = "123456"
          user = new User {username, email, password}
          user.save (err, doc) ->
            done()

      it "should be unique", (done) ->

        userCredentials = 
          username: "paul"
          email:    "paul@anephenix.com"
          password: "123456"

        new User(userCredentials).save (err, doc) ->
          assert.notEqual err, null
          User.count (err, count) ->
            assert.equal count, 1
            done()

      it "should be present", (done) ->
        userCredentials = 
          username: "ren"
          password: "123456"

        new User(userCredentials).save (err, doc) ->
          assert.notEqual err, null
          done()

    describe "password", ->

      it "should be present", (done) ->

        userCredentials = 
          username: "ren"
          email: "ren@renandstimpy.com"

        new User(userCredentials).save (err, doc) ->
          assert.notEqual err, null
          done()


  describe ".authenticate", ->

    before (done) ->
      User.remove {}, (err) ->
        username  = "paulbjensen"
        email     = "paul@anephenix.com"
        password  = "123456"
        user = new User {username, email, password}
        user.save (err, doc) ->
          done()

    describe "when the user exists and the password is correct", ->

      it "should return a successful status along with the user record", (done) ->
        User.authenticate {identifier: "paulbjensen", password: "123456"}, (response) ->
          assert response.status is "success"
          assert response.user.username is "paulbjensen"
          assert response.user.email is "paul@anephenix.com"
          done()


    describe "when the user exists but the password is incorrect", ->

      it "should return a failure status along with stating that the password is incorrect", (done) ->
        User.authenticate {identifier: "paulbjensen", password: "1234567"}, (response) ->
          assert response.status is "failure"
          assert response.reason is "password incorrect"
          done()

    describe "when the user does not exist", ->

      it "should return a failure status along with stating that the user does not exist", (done) ->
        User.authenticate {identifier: "ziggywazoo", password: "istherelifeonmars"}, (response) ->
          assert response.status is "failure"
          assert response.reason is "the user ziggywazoo does not exist"
          done()