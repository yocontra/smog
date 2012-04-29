{Server, Db} = require 'mongodb'

module.exports = (reply, socket, host, port, database) ->
  return reply "Missing host" unless host? and typeof host is 'string' and host.length > 0
  return reply "Missing port" unless port? and typeof port is 'number'
  return reply "Missing database" unless database? and typeof database is 'string' and database.length > 0
  return reply null, true if socket.mongo? and socket.mongo.database?

  socket.mongo = {}
  socket.mongo.server = new Server host, port, auto_reconnect: true
  dbt = new Db database, socket.mongo.server, strict: true

  dbt.open (err, db) ->
    return reply err if err?
    socket.mongo.database = db
    return reply null, true