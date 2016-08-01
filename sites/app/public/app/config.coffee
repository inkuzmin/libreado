if exports?
  config = exports
else
  config = {}
  define [], () ->
    config

config.lang =
  supported: ["en", "ru"]
  default: "en"