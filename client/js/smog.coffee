define ["smog/server", "smog/routes", "smog/notify"], (server, routes, notify) ->

  dermis.use (mod, args, next) ->
    server.ready (services) -> next()
    
  server.ready (services) ->
    console.log "Connected - Available services: #{services}"

  #server.close ->
  #  notify.error 'Connection lost - reload to re-establish'