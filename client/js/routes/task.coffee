define ["smog/server", "smog/notify"], (server, notify) ->
  ({name, id}) ->
    server.collection
      collection: name.toLowerCase()
      type: 'delete'
      query:
        _id: id
      (err) ->
        return notify.error "Error deleting document: #{err}" if err?