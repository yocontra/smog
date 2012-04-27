connect = require "connect"
router = require "./lib/router"

# Web server
app = connect()
app.use connect.staticCache()
app.use connect.static './public/'
server = app.listen 8080

# Vein
router.initialize server, __dirname, './lib/services/', (err) ->
  return console.log err if err?
  console.log "Server started on 8080"