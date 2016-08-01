define [
  "backbone"
  "routers/welcome"
], (Backbone, WelcomeRouter) ->

  Backbone.Router.extend
    routes:
      "": "redirectToWelcomeModule"
      "welcome/*subroute": "redirectToWelcomeModule"
    redirectToWelcomeModule: ->
      if not welcomeRouter
        welcomeRouter = new WelcomeRouter "welcome"
    index: ->
      console.log "index"
    register: ->
      console.log "register"




#    routes:
#      ":lang/*subroute": "redirectToLocaleModule"
#    redirectToLocaleModule: (lang) ->
#      lang = if lang in Config.lang.supported then lang else Config.lang.default
#      if not routers.localeRouter
#        routers.localeRouter = new LocaleRouter "#{lang}"

#      new LocaleRouter "#{lang}"