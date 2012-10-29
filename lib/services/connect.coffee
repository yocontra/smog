mongo = require 'mongoskin'

module.exports = (cb, host) ->
  #console.log "connect #{host}"
  return cb "Missing connection string" unless typeof host is 'string'
  return cb null, true if cb.socket.mongo?.database?

  cb.socket.mongo = {}
  db = cb.socket.mongo.database = mongo.db host
  cb null, true