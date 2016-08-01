# File: app/login/main.coffee

define [
  "modules/welcome/views/welcome"
  "blur"
  "parralax"
], (WelcomeView) ->

  attachPlugins =->
    # Frozen glass effect
    $('.welcome-background').blurjs
      source: '#content'
      overlay: 'rgba(255,255,255,0.4)'
      offset:
        x: 0
        y: -12
      fluid: true
      radius: 5
      customCSS:
        'opacity': '1'

    # Parallax effect for iOS
    if Modernizr.touch
      $(".welcome-panel").addClass("layer").data("depth", "0.15")
      $content = $("#content").parallax
        css3: false
      $('input').focusin ()->
        $content.parallax "disable"
      $('input').focusout ()->
        $content.parallax "enable"

  showWelcomeView =->
    welcomeView = new WelcomeView()
    $('#content').html welcomeView.render().el
    attachPlugins()

  _.extend {},
    init: showWelcomeView