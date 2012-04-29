{ObjectID} = require 'mongodb'

getObjectID = (str) ->
  try
    return new ObjectID str
  catch error
    return str

tasks =
  # collection tasks
  rename: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    return cb "Missing name" unless command.query.name?
    col.rename command.query.name, (err, res) ->
      return cb err if err?
      return cb "Rename failed" unless res?
      cb()

  empty: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    col.remove (err, res) ->
      return cb err if err?
      return cb "Empty failed" unless res?
      cb()

  drop: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    col.drop (err, res) ->
      return cb err if err?
      return cb "Drop failed" unless res?
      cb()

  # other
  find: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    col.find(command.query, command.options).toArray (err, res) ->
      return cb err if err?
      cb null, res

  delete: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    return cb "Missing _id" unless command.query._id?
    col.remove {_id:command.query._id}, {safe:true}, (err, res) ->
      return cb err if err?
      return cb "Delete failed" unless res? and res > 0
      cb()

  update: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    return cb "Missing _id" unless command.query._id?
    col.save command.query, cb


module.exports = (reply, socket, command) ->
  console.log command
  return reply "Not connected" unless socket.mongo?
  return reply "Missing command" unless command?
  return reply "Missing type" unless command.type?
  return reply "Missing collection" unless command.collection?
  return reply "Invalid command" unless tasks[command.type]?

  socket.mongo.database.collection command.collection, {safe:true}, (err, col) ->
    return cb err if err?
    tasks[command.type] col, command, reply