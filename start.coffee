connect = require "connect"
{join} = require "path"
Vein = require 'vein'

# Web server
app = connect()
app.use connect.staticCache()
app.use connect.static join __dirname, './public/'
server = app.listen process.env.PORT or 8080

# Vein
vein = new Vein server
vein.addFolder join __dirname, './lib/services/'

console.log "Server started on 8080"