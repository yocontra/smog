connect = require "connect"
router = require "./lib/router"
{join} = require "path"

# Web server
app = connect()
app.use connect.staticCache()
app.use connect.static join __dirname, './public/'
server = app.listen process.env.PORT or 8080

# Vein
router.initialize server, join(__dirname, './lib/services/'), (err) ->
  return console.log err if err?
  console.log "Server started on 8080"
