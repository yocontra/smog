{Server, Db} = require 'mongodb'

module.exports = (cb, host, port, database) ->
  return cb "Missing host" unless host? and typeof host is 'string' and host.length > 0
  return cb "Missing port" unless port? and typeof port is 'number'
  return cb "Missing database" unless database? and typeof database is 'string' and database.length > 0
  return cb null, true if cb.socket.mongo?.database?

  cb.socket.mongo = {}
  cb.socket.mongo.server = new Server host, port, auto_reconnect: true
  dbt = new Db database, cb.socket.mongo.server, strict: true

  dbt.open (err, db) ->
    return cb err if err?
    cb.socket.mongo.database = db
    db.admin (err, admin) ->
      return cb err if err?
      cb.socket.mongo.admin = admin
      return cb null, true