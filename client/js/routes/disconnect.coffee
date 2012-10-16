define ["smog/server", "smog/notify"], (server, notify) ->
  show: ->
    server.disconnect (err) ->
      return notify.error "Error disconnecting: #{err}" if err?
      window.location = '/'