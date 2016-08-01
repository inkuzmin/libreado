define [
  "backbone"
  "i18n!nls/welcome/info"
  "hbs!templates/welcome/info"
  "css!assets/styles/welcome/info"
], (Backbone, infoNls, infoTpl) ->
  Backbone.View.extend
    manage: true
    template: infoTpl
    serialize: infoNls

#    render: ->
#      data = test: login.blue
#      html = coverTpl(data)
#      @.$el.html(html)
#      @