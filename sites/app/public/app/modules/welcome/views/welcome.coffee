define [
  "backbone"
  "i18n!nls/welcome/welcome"
  "hbs!templates/welcome/welcome"
  "modules/welcome/views/login"
  "modules/welcome/views/invite"
  "modules/welcome/views/info"
  "app/pubsub"
  "layoutmanager"
  "css!assets/styles/welcome/welcome"
], (Backbone, welcomeNls, welcomeTpl, Login, Invite, Info, PubSub) ->

  Backbone.Layout.extend
    initialize:->
      @listenTo PubSub, "welcome:lol", @insertInvite

    template: welcomeTpl
    serialize: -> welcomeNls
    views:
      ".welcome-content": new Login
      ".welcome-information": new Info

    insertInvite: ->
      @insertView ".welcome-content", new Invite
      .render()

      @setView ".welcome-information", new Info
      .render()

#    render: ->
#      data =
#        "email_or_login": T.email_or_login
#        "password": T.password
#        "remember": T.remember
#        "register": T.register
#        "forgot": T.forgot
#        "welcome_title": T.welcome_title
#        "welcome_text": T.welcome_text
#      console.log data
#      html = coverTpl(T)
#      @.$el.html(html)
#      @