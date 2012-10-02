module.exports = (cb, socket) ->
  return cb "Not connected" unless cb.socket.mongo?

  out = {}
  db = cb.socket.mongo.database
  admin = cb.socket.mongo.admin

  db.collectionNames (err, r) ->
    return cb err if err?
    out.collections = r

    admin.serverStatus (err, r) ->
      return cb err if err?
      out.serverStatus = r

      admin.buildInfo (err, r) ->
        return cb err if err?
        out.buildInfo = r

        admin.profilingLevel (err, r) ->
          return cb err if err?
          out.profilingLevel = r

          admin.profilingInfo (err, r) ->
            return cb err if err?
            out.profilingInfo = r

            admin.replSetGetStatus (err, r) ->
              out.replSetGetStatus = r unless err?
              return cb null, out