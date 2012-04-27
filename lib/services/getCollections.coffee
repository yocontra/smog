{Db} = require 'mongodb'

module.exports = (reply, socket) ->
  return reply "Not connected" unless socket.mongo?

  socket.mongo.database.collectionsInfo().toArray reply