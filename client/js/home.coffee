define ["smog/server", "templates/navigation", "smog/notify"], (server, templ, notify) ->
  ->
    server.getCollections (err, coll) ->
      return notify.error "Error grabbing collections: #{err}" if err?
      coll = (it.name.substring(it.name.indexOf('.')+1) for it in coll)
      $('#navigation').html templ collections: coll
      $('#content').html ''