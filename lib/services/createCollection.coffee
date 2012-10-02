module.exports = (cb, name, options={}) ->
  return cb "Not connected" unless cb.socket.mongo?
  return cb "Missing name" unless name? and typeof name is "string" and name.length > 0

  options.safe = true
  cb.socket.mongo.database.createCollection name, options, (err, col) ->
    return cb err if err?
    return cb "Not created" unless col?
    cb()