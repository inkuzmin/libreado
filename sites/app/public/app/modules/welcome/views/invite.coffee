define [
  "backbone"
  "i18n!nls/welcome/invite"
  "hbs!templates/welcome/invite"
  "css!assets/styles/welcome/invite"
], (Backbone, inviteNls, inviteTpl) ->
  Backbone.View.extend
    manage: true
    template: inviteTpl
    serialize: inviteNls

    afterRender: ->

      @$el.css "position", "relative"

      topOffset = parseInt @$el.find(".invite").css "top" # -35 by CSS



#      @$el.find("h2").css
#        "font-size": "1em"
#      .animate
#        "font-size": "1.5em"
#      , 1200
      @$el.animate
        "top": "-=#{@$el.parent().height() + topOffset}"
      , 900, ()->
          $(@).css "top", 0
          $(@).find(".invite").css "top", 0