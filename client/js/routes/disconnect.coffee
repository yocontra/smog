define ["smog/server", "smog/notify"], (server, notify) ->
  ->
    server.disconnect (err, res) ->
      return notify.error "Error disconnecting: #{err}" if err?
      window.location = '/'