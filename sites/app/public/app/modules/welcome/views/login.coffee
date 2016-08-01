define [
  "backbone"
  "i18n!nls/welcome/login"
  "hbs!templates/welcome/login"
  "app/pubsub"
  "css!assets/styles/welcome/login"
], (Backbone, loginNls, loginTpl, PubSub) ->
  Backbone.View.extend
    manage: true
    template: loginTpl
    serialize: loginNls
    events:
      "click .welcome-register": "slideUp"
    slideUp: ->
      @$el.css "position", "relative"
      @$el.parent().height @$el.parent().height()

      PubSub.trigger("welcome:lol", "my message")

      @$el.find(".welcome-register").css "visibility", "hidden"

      @$el.animate
        "top": "-=#{@$el.outerHeight()}"
      , 900, ()=>
          @$el.hide()
          @$el.parent().height "auto"

          @removeWithStyles()

    removeWithStyles: ->
      @$el.removeAttr "style"
      @remove()