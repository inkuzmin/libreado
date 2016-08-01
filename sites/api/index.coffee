express = require 'express'
path = require 'path'

app = express()

pub = path.join __dirname, '/public'

app.use express.static(pub)

app.set 'views', "#{__dirname}/views"
app.set 'view engine', 'jade'

#app.engine('jade', require('jade').__express);

app.get '/', (req, res) ->
  res.render 'users', { users: {'111':'111'} }

app.use (err, req, res, next) ->
  res.send err.stack

#if (!module.parent)
#    app.listen 3000
#    console.log 'Express started on port 3000'
#else
module.exports = app