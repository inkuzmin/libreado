express = require "express"
path = require "path"
locale = require "locale"
url = require "url"

user = require path.join(__dirname, "/models/user.js")

mongoose = require "mongoose"

mongoose.connect "mongodb://localhost/ololo", (err)->
  console.log err


config = require "#{__dirname}/public/app/config.js"

User = user config, mongoose


User.createUser "testlol"

app = express()

pub = path.join __dirname, "/public"
app.use express.static(pub)

locale.Locale.default = config.lang.default
app.use locale config.lang.supported

app.set "views", "#{__dirname}/views"
app.set "view engine", "jade"

app.get "/account/authenticated", (q, s) ->
  s.status(400).send('Not found')

app.get "/:lang/*", (req, res) ->
  # Поскольку автоматическое определение языка может породить больше
  # неудобств чем удобств (в силу неочевидности), алгоритм крайне
  # прост и ясен:
  # если запрос пришел с указанием существующего языка - ставим его
  #   if req.params.lang in config.lang.supported
  #     lang = req.params.lang
  # иначе определяем по заголовку запроса и если он есть - ставим,
  # а если нет - используем язык по умолчанию
  #   else
  #     lang = req.locale
  lang = if req.params.lang in config.lang.supported then req.params.lang else req.locale
  res.render "index",
    "lang": lang

app.get "*", (req, res) ->
  res.render "index",
    "lang": req.locale

app.use (err, req, res, next) ->
  res.send err.stack

if not module.parent
  app.listen 3000
  console.log 'Express started on port 3000'
else
  module.exports = app