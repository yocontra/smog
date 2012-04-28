define ["smog/server", "templates/navigation", "templates/sidebar", "smog/notify"], (server, nav, sidebar, notify) ->
  ->
    server.collections (err, coll) ->
      return notify.error "Error grabbing collections: #{err}" if err?

      # Filter collection names
      coll = (it.name.substring(it.name.indexOf('.')+1) for it in coll when it.name.indexOf('.system.') is -1)
      coll = ("#{name.charAt(0).toUpperCase()}#{name.slice(1)}" for name in coll)

      $('#navigation').html nav loggedIn: true
      $('#sidebar').html sidebar collections: coll
      $('#content').html ''