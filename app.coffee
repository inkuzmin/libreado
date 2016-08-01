express = require 'express'
app = express()
force = require 'express-force-domain'
forceSSL = require 'express-force-ssl'
https = require 'https'
http = require 'http'
vhost = require 'vhost'
fs = require 'fs'

# No cache mode
noCache = require('connect-nocache')

# SSL certificate options
options =
  key: fs.readFileSync('./keys/libreado.com.key')
  cert: fs.readFileSync('./keys/libreado.com.crt')
  ca: fs.readFileSync('./keys/rootCA.crt')

# Force SSL connection
app.use forceSSL

# Force redirection to www
app.use require('connect-redirecthost').redirectHost
  to: 'www.libreado.com'
  except: ['app.libreado.com', 'api.libreado.com']

# Route to appropriate app
app.use vhost('app.libreado.com', require('./sites/app'))
app.use vhost('www.libreado.com', require('./sites/www'))
app.use vhost('api.libreado.com', require('./sites/api'))

# Start servers
secureServer = https.createServer(options, app)
server = http.createServer(app)

secureServer.listen(8443)
server.listen(8080)