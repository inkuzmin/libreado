# /etc/hosts must contain follow lines
# 127.0.0.1	libreado.com
# 127.0.0.1	www.libreado.com
# 127.0.0.1	read.libreado.com
# 127.0.0.1	api.libreado.com
# 127.0.0.1	test.libreado.com
# 127.0.0.1	libreado.ru
# 127.0.0.1	www.libreado.ru
# 127.0.0.1	read.libreado.ru
# 127.0.0.1	api.libreado.ru
# 127.0.0.1	test.libreado.ru

# Server must redirect from non-priveleged ports to priveleged
# sudo ipfw add 100 fwd 127.0.0.1,8443 tcp from any to any 443 in
# sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to any 80 in

# Constants for server testing
__hostname = "libreado.com"
__altHostnames = ["libreado.ru", "libreado.net", "libreado.org", "libreado.info"]

# Increase pool size to avoid 5 sockets limit error
require("http").globalAgent.maxSockets = 1000;
require("https").globalAgent.maxSockets = 1000;

# Disable auto-signed ssl rejection
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"

# Add libraries
request = require "request"
should = require("chai").should()

# Start app
app = require "../app"

describe "Redirections", ->
  describe "Open http://libreado.com:8080", ->
    it "should return at 200 response code", (done) ->
      request "http://#{__hostname}:8080", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://#{__hostname}:8080", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "and port", (done) ->
      request "http://#{__hostname}:8080", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should redirect to www subdomain", (done) ->
      request "http://#{__hostname}:8080", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/www/);
        done()

  describe "Open http://libreado.com:80", ->
    it "should return at 200 response code", (done) ->
      request "http://#{__hostname}:80", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://#{__hostname}:80", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "and port", (done) ->
      request "http://#{__hostname}:80", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should redirect to www subdomain", (done) ->
      request "http://#{__hostname}:80", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/www/);
        done()

  describe "Open http://libreado.com", ->
    it "should return at 200 response code", (done) ->
      request "http://#{__hostname}", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "should redirect to uri with security port", (done) ->
      request "http://#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should redirect to www subdomain", (done) ->
      request "http://#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/www/);
        done()

  describe "Open http://test.libreado.com", ->
    it "should return 200 as response code", (done) ->
      request "http://test.#{__hostname}", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://test.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "should redirect to uri with security port", (done) ->
      request "http://test.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should redirect to www subdomain", (done) ->
      request "http://test.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/www/);
        done()

  describe "Open http://www.libreado.com", ->
    it "should return 200 as response code", (done) ->
      request "http://www.#{__hostname}", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://www.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "should redirect to uri with security port", (done) ->
      request "http://www.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should save www as subdomain", (done) ->
      request "http://www.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/www/);
        done()


  describe "Open http://api.libreado.com", ->
    it "should return 200 as response code", (done) ->
      request "http://api.#{__hostname}", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://api.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "should redirect to uri with security port", (done) ->
      request "http://api.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should not contain www as subdomain", (done) ->
      request "http://api.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.not.match(/www/);
        done()
    it "should contain api as subdomain", (done) ->
      request "http://api.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/api/);
        done()

  describe "Open http://app.libreado.com", ->
    it "should return 200 as response code", (done) ->
      request "http://app.#{__hostname}", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://app.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "should redirect to uri with security port", (done) ->
      request "http://app.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should not contain www as subdomain", (done) ->
      request "http://app.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.not.match(/www/);
        done()
    it "should contain api as subdomain", (done) ->
      request "http://app.#{__hostname}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/app/);
        done()

  describe "Open http://libreado.ru", ->
    it "should return 200 as response code", (done) ->
      request "http://#{__altHostnames[0]}", (err, res, body) ->
        res.statusCode.should.equal 200
        done()
    it "should redirect to uri with security protocol", (done) ->
      request "http://#{__altHostnames[0]}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/^https:/);
        done()
    it "should redirect to uri with security port", (done) ->
      request "http://#{__altHostnames[0]}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/:443\/$/);
        done()
    it "should not contain www as subdomain", (done) ->
      request "http://#{__altHostnames[0]}", (err, res, body) ->
        reqUri = res.request.uri.href
        reqUri.should.match(/www/);
        done()