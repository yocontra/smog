{Server, Db} = require 'mongodb'

module.exports = (reply, socket, host, port, database) ->
  return reply "Not connected" unless socket.mongo?

  socket.mongo.database.close true, reply
  delete socket.mongo