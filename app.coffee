require('coffee-script')
config    = require("./config")
cors      = require('cors')
cube      = require("cube")
express   = require('express')
http      = require('http')
logger    = require('logfmt')
pkg       = require('./package.json')
requestid = require('connect-requestid')
app       = express()

app.set 'port', config.port
app.set 'version', pkg.version
app.use logger.requestLogger()
app.use express.json()
app.use express.methodOverride()
app.use express.responseTime()
app.use requestid

# CORS
corsOptions = { origin: true, credentials: true }
app.use cors(corsOptions)
app.options('*', cors(corsOptions))

# Basic auth
if config.is(config.basicAuthUsername) && config.is(config.basicAuthPassword)
  logger.log(msg: "Enabling BASIC authentication.", username: config.basicAuthUsername)
  app.use express.basicAuth(config.basicAuthUsername, config.basicAuthPassword)

# Connect to database and configure server.
start = (callback) ->
  options =
    'mongo-url': config.mongoUrl
    'mongo-username': config.mongoUser
    'mongo-password':  config.mongoPass
    "http-port":  config.port

  server = cube.server(options)

  server.register = (db, endpoints) ->

    app.set('db', db)

    cube.evaluator.register(db, endpoints)

  server.start()

module.exports = {server: app, start: start}
