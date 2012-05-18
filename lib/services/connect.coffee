{Server, Db} = require 'mongodb'

module.exports = (res, host, port, database) ->
  return res.send "Missing host" unless host? and typeof host is 'string' and host.length > 0
  return res.send "Missing port" unless port? and typeof port is 'number'
  return res.send "Missing database" unless database? and typeof database is 'string' and database.length > 0
  return res.send null, true if res.socket.mongo? and res.socket.mongo.database?

  res.socket.mongo = {}
  res.socket.mongo.server = new Server host, port, auto_reconnect: true
  dbt = new Db database, res.socket.mongo.server, strict: true

  dbt.open (err, db) ->
    return res.send err if err?
    res.socket.mongo.database = db
    db.admin (err, admin) ->
      return res.send err if err?
      res.socket.mongo.admin = admin
      return res.send null, true