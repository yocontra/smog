module.exports = (res, name, options={}) ->
  return res.send "Not connected" unless res.socket.mongo?
  return res.send "Missing name" unless name? and typeof name is "string" and name.length > 0

  options.safe = true
  res.socket.mongo.database.createCollection name, options, (err, col) ->
    return res.send err if err?
    return res.send "Not created" unless col?
    res.send()