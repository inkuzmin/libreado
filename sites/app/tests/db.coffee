# Add libraries
request = require "request"
should = require("chai").should()

user = require "../models/user"
invite = require "../models/invite"

# Params: (config, mongoose, nodemailer)
config =
  maxUsers: 1000
  mail: "invite@libreado.com"



mongoose = require "mongoose"
nodemailer = require "nodemailer"

mongoose.connect "mongodb://localhost/ololo", (err)->
  console.log err


User = user config, mongoose

Invite = invite config, mongoose, nodemailer, User.model

invite =
  _id: "test"
  email: "inkuzmin@ya.ru"

#console.log Invite.handleEmail("inkuzmin@ya.ru")


#Invite.createInvite "erafjgkfjdl"

describe "Redirections", ->
  describe "Open http://libreado.com:8080", ->
    it "should return at 200 response code", (done) ->
      User.createUser "testlol"
      done()
