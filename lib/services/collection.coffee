ton = require "mongo-ton"
uglify = require "uglify-js"
{BSON} = require('mongodb').pure()

prettify = (code) -> 
  try
    ish = uglify.uglify.gen_code uglify.parser.parse("(#{code})"), beautify: true, quote_keys: true
    return ish.substring 1, ish.length-2
  catch err
    console.log code
    return "Error parsing"

formatDocuments = (res) ->
  out = []
  for doc in res
    out.push 
      _id: doc._id
      nativeId: (doc._id instanceof ObjectID)
      size: BSON.calculateObjectSize(doc, true)
      value: prettify ton.stringify doc
  return out

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
    command.options ?= {}
    col.find(command.query, command.options).toArray (err, res) ->
      return cb err if err?
      return cb null, [] unless res?
      cb null, formatDocuments res

  mapReduce: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    {map, reduce} = command.query
    return cb "Missing map" unless typeof map is 'function'
    return cb "Missing reduce" unless typeof reduce is 'function'
    col.mapReduce map, reduce, {out:{inline:1}}, (err, res, stat) ->
      return cb err if err?
      cb null, formatDocuments(res), stat

  delete: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    return cb "Missing _id" unless command.query._id?
    col.remove {_id:command.query._id}, {safe:true}, (err, res) ->
      return cb err if err?
      return cb "Delete failed" unless res? and res > 0
      cb()

  insert: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    col.insert command.query, {safe:true}, cb

  update: (col, command, cb) ->
    return cb "Missing query" unless command.query?
    return cb "Missing _id" unless command.query._id?
    col.save command.query, cb


module.exports = (res, command) ->
  return unless res.socket?
  return res.send "Not connected" unless res.socket.mongo?
  return res.send "Missing command" unless command?
  return res.send "Missing type" unless command.type?
  return res.send "Missing collection" unless command.collection?
  return res.send "Invalid command" unless tasks[command.type]?

  res.socket.mongo.database.collection command.collection, {safe:true}, (err, col) ->
    return res.send err if err?
    if command.query? and typeof command.query is 'string'
      try
        command.query = ton.parse command.query
      catch err
        return res.send err.message
    tasks[command.type] col, command, res.send