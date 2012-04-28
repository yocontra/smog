define ["smog/server", "smog/routes", "smog/notify", "templates/navigation"], (server, routes, notify, nav) ->

  $('#navigation').html nav loggedIn: false
  server.ready (services) ->
    console.log "Connected - Available services: #{services}"
    $.routes routes

  server.close ->
    notify.error 'Connection lost - reload to re-establish'