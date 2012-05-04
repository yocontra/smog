ton = require "mongo-ton"
uglify = require "uglify-js"
prettify = (code) -> 
  try
    ish = uglify.uglify.gen_code uglify.parser.parse("(#{code})"), beautify: true, quote_keys: true
    return ish.substring 1, ish.length-2
  catch err
    console.log code
    return "Error parsing"
    
tasks =
  # collection tasks
  rename: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    return cb "Missing name" unless command.query.name? and typeof command.query.name is 'string' and command.query.name.length > 0
    col.rename command.query.name, (err, res) ->
      return cb err if err?
      return cb "Rename failed" unless res?
      cb()

  empty: (col, command, cb) ->
    col.remove (err, res) ->
      return cb err if err?
      return cb "Empty failed" unless res?
      cb()

  drop: (col, command, cb) ->
    col.drop (err, res) ->
      return cb err if err?
      return cb "Drop failed" unless res?
      cb()

  # other
  find: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    try
      command.query = ton.parse command.query
    catch err
      return cb err.message
    col.find(command.query, command.options).toArray (err, res) ->
      return cb err if err?
      return cb null, [] unless res?
      cb null, ({_id: doc._id, nativeId: (doc._id instanceof ObjectID), value: prettify(ton.stringify(doc))} for doc in res)

  delete: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    try
      command.query = ton.parse command.query
    catch err
      return cb err.message
    return cb "Missing _id" unless command.query._id?
    col.remove {_id:command.query._id}, {safe:true}, (err, res) ->
      return cb err if err?
      return cb "Delete failed" unless res? and res > 0
      cb()

  insert: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    try
      command.query = ton.parse command.query
    catch err
      return cb err.message
    col.insert command.query, {safe:true}, cb

  update: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    try
      command.query = ton.parse command.query
    catch err
      return cb err.message
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
    return reply err if err?
    tasks[command.type] col, command, reply