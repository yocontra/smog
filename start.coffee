connect = require "connect"
{join} = require "path"
Vein = require 'vein'

port = process.env.PORT or 8080

# Web server
app = connect()
app.use connect.staticCache()
app.use connect.static join __dirname, './public/'
server = app.listen port

# Vein
vein = Vein.createServer server: server
vein.addFolder join __dirname, './lib/services/'

console.log "Server started on #{port}"

if process.argv[2] is '-u'
  try
    Pane = require 'pane'
    opt =
      title: "Smog"
      height: 700
      width: 1200
      url: "http://localhost:#{port}"

    process.nextTick ->
      window = new Pane opt
      window.open()
  catch err
    console.log 'You need to install libqtwebkit-dev to use the desktop UI.'