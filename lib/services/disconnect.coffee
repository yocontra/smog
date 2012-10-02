module.exports = (cb, host, port, database) ->
  return cb "Not connected" unless cb.socket.mongo?

  cb.socket.mongo.database.close (err) ->
    return cb err if err?
    cb()
    delete cb.socket.mongo