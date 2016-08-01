require.config
  baseUrl: "/libs"
  paths:
    jquery: "jquery/jquery"
    blur: "jquery/blur"
    parralax: "jquery/parralax"

    underscore: "underscore/underscore"
    lodash: "underscore/lodash"

    backbone: "backbone/backbone"
    subroute: "backbone/subroute"
    layoutmanager: "backbone/layoutmanager"

    modernizr: "modernizr"

    app: "/app"
    routers: "/app/routers"
    modules: "/app/modules"
    
    nls: "/nls"

    i18n: "require/i18n"
    css: "require/css"
    hbs: "require/hbs"

    assets: "/assets"
    templates: "/templates"
    typekit: "//use.typekit.net/uno0hgu"
  shim:
    "modernizr":
#      deps: [""]
      exports: "Modernizr"
    "typekit":
      exports: "Typekit"
  config:
    i18n:
      locale: document.body.parentNode.getAttribute "lang"
  hbs:
    templateExtension: 'html'


require [
  "app/app"
], (App) ->
  App.init()