module.exports = (res, socket) ->
  return res.send "Not connected" unless res.socket.mongo?

  out = {}
  db = res.socket.mongo.database
  admin = res.socket.mongo.admin

  db.collectionNames (err, r) ->
    return res.send err if err?
    out.collections = r

    admin.serverStatus (err, r) ->
      return res.send err if err?
      out.serverStatus = r

      admin.buildInfo (err, r) ->
        return res.send err if err?
        out.buildInfo = r

        admin.profilingLevel (err, r) ->
          return res.send err if err?
          out.profilingLevel = r

          admin.profilingInfo (err, r) ->
            return res.send err if err?
            out.profilingInfo = r

            admin.replSetGetStatus (err, r) ->
              out.replSetGetStatus = r unless err?
              return res.send null, out