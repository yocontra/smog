{Server, Db} = require 'mongodb'

module.exports = (res, host, port, database) ->
  return es.send "Not connected" unless res.socket.mongo?

  res.socket.mongo.database.close true, (err) ->
    return res.send err if err?
    res.send()
    delete res.socket.mongo