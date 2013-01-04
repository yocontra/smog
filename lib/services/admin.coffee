module.exports = (cb, socket) ->
  return cb "Not connected" unless cb.socket.mongo.database?

  out = {}
  db = cb.socket.mongo.database
  admin = db.admin

  # authenticate against "admin" db first, then go back to original.
  if db._dbconn.options.password
    dbOrig = db._dbconn.databaseName
    db._dbconn.databaseName = "admin"
    db.open  (err, r) ->
      db._dbconn.databaseName = dbOrig
      db.open (err, r) ->

        db.collectionNames (err, r) ->
          return cb err.message if err?
          out.collections = r
      
          admin.serverStatus (err, r) ->
            # return cb err.message if err?
            out.serverStatus = r unless err?
      
            admin.buildInfo (err, r) ->
              # return cb err.message if err?
              out.buildInfo = r unless err?
      
              admin.profilingLevel (err, r) ->
                # return cb err.message if err?
                out.profilingLevel = r unless err?
      
                admin.profilingInfo (err, r) ->
                  # return cb err.message if err?
                  out.profilingInfo = r unless err?
      
                  admin.replSetGetStatus (err, r) ->
                    out.replSetGetStatus = r unless err?
                    return cb null, out