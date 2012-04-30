prettySeconds = (secs) ->
  days = Math.floor secs / 86400
  hours = Math.floor (secs % 86400) / 3600
  minutes = Math.floor ((secs % 86400) % 3600) / 60
  seconds = ((secs % 86400) % 3600) % 60
  out = ""
  out += "#{days} days " if days > 0
  out += "#{hours} hours " if hours > 0
  out += "#{minutes} minutes" if minutes > 0
  out += " #{seconds} seconds" if seconds > 0 and days <= 0 
  return out

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
      info.serverStatus.uptime = prettySeconds info.serverStatus.uptime
      $('#content').html admin info