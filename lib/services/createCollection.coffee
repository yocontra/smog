module.exports = (reply, socket, name, options={}) ->
  return reply "Not connected" unless socket.mongo?
  return reply "Missing name" unless name? and typeof name is "string" and name.length > 0

  options.safe = true
  socket.mongo.database.createCollection name, options, (err, col) ->
    return reply err if err?
    return reply "Not created" unless col?
    reply null
