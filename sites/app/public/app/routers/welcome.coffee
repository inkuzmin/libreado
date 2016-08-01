define [
  "backbone"
  "app/modules/welcome/main"
  "subroute"
], (Backbone, Welcome) ->

  Backbone.SubRoute.extend
    routes:
      "": "login"
      "login": "login"
      "register": "register"
    login: ->
      Welcome.init()
    index: ->
      console.log "Route to index..."
    register: ->
      console.log "Route to register..."