module.exports = (reply, socket) ->
  return reply "Not connected" unless socket.mongo?

  out = {}
  db = socket.mongo.database
  admin = socket.mongo.admin

  db.collectionNames (err, res) ->
    return reply err if err?
    out.collections = res

    admin.serverStatus (err, res) ->
      return reply err if err?
      out.serverStatus = res

      admin.buildInfo (err, res) ->
        return reply err if err?
        out.buildInfo = res

        admin.profilingLevel (err, res) ->
          return reply err if err?
          out.profilingLevel = res

          admin.profilingInfo (err, res) ->
            return reply err if err?
            out.profilingInfo = res

            admin.replSetGetStatus (err, res) ->
              out.replSetGetStatus = res unless err?
              return reply null, out