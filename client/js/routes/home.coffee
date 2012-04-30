define ["smog/server",  "templates/sidebar", "templates/admin", "smog/notify"], (server, sidebar, admin, notify) ->
  ->
    server.admin (err, info) ->
      return notify.error "Error grabbing information: #{err}" if err?

      # Filter collection names
      info.collections = (it.name.substring(it.name.indexOf('.')+1) for it in info.collections when it.name.indexOf('.system.') is -1)
      info.collections = ("#{name.charAt(0).toUpperCase()}#{name.slice(1)}" for name in info.collections)
      $('#sidebar').html sidebar info

      # Filter admin info
      info.serverStatus.network.bytesIn = Math.round info.serverStatus.network.bytesIn/1000/1000
      info.serverStatus.network.bytesOut = Math.round info.serverStatus.network.bytesOut/1000/1000
      info.serverStatus.connections.total = info.serverStatus.connections.current + info.serverStatus.connections.available
      $('#content').html admin info