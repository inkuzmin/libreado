define [
  "jquery"
  "lodash"
  "backbone"
  "modernizr"
  "routers/app"
  "typekit"
  "css!assets/styles/normalize.css"
], ($, _, Backbone, Modernizr, AppRouter, typekit) ->
  init = () ->
    try typekit.load()
    checkLogin runApp

  initRouter = ->
    router = new AppRouter
    lang = $("html").attr "lang"
    Backbone.history.start
      pushState: true
      root: "/#{lang}"
    $(document).on "click", "a:not([data-bypass])", (e) ->
      href = $(this).attr "href"
      protocol = this.protocol + "//"
      if href.slice(protocol.length) isnt protocol
        e.preventDefault()
        router.navigate href.replace("..", ""), true
    router

  checkLogin = (callback) ->
    $.ajax "/account/authenticated",
      method: "GET"
      success: () ->
        callback(true)
      error: (data) ->
        callback(false)

  runApp = (isAuthenticated) ->
    router = initRouter()
    if isAuthenticated
      router.navigate "index", true
    else
      router.navigate "welcome/login", true

  _.extend {},
    init: init