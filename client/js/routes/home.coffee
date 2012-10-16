define ["smog/server", "smog/util", "smog/notify", "templates/sidebar", "templates/admin"], (server, util, notify, sidebar, admin) ->
  show: ->
    server.admin (err, info) ->
      return notify.error "Error grabbing information: #{err.err or err}" if err?

      # Filter collection names
      info.collections = util.filterCollections info.collections
      $('#sidebar').html sidebar info

      # Filter admin info
      info.serverStatus.network.bytesIn = util.readableSize info.serverStatus.network.bytesIn
      info.serverStatus.network.bytesOut = util.readableSize info.serverStatus.network.bytesOut
      info.serverStatus.mem.mapped = "#{info.serverStatus.mem.mapped} MB"
      info.serverStatus.mem.virtual = "#{info.serverStatus.mem.virtual} MB"
      info.serverStatus.connections.total = info.serverStatus.connections.current + info.serverStatus.connections.available
      info.serverStatus.uptime = util.prettySeconds info.serverStatus.uptime
      $('#content').html admin info