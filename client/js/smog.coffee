define ["smog/server", "smog/routes", "smog/notify"], (server, routes, notify) ->

  server.ready (services) ->
    console.log "Connected - Available services: #{services}"
    $.routes routes

  server.close ->
    notify.error 'Connection lost - reload to re-establish'