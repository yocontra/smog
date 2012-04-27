{Server, Db} = require 'mongodb'

module.exports = (reply, socket, host, port, database) ->
  return reply "Missing host" unless host?
  return reply "Missing port" unless port?
  return reply "Missing database" unless database?
  return reply null, true if socket.mongo? and socket.mongo.database?

  socket.mongo = {}
  socket.mongo.server = new Server host, port, auto_reconnect: true
  dbt = new Db database, socket.mongo.server, auto_reconnect: true

  dbt.open (err, db) ->
    return reply err if err?
    socket.mongo.database = db
    return reply null, true