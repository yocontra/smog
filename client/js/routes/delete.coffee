define ["smog/server", "smog/notify"], (server, notify) ->
  show: ({name, id, nativeId}) ->
    if nativeId is 'true'
      q = '{"_id": new ObjectID("' + id + '")}'
    else
      q = '{"_id": "' + id + '"}'
    console.log q
    server.collection
      collection: name
      type: 'delete'
      query: q
      (err) ->
        return notify.error "Error deleting document: #{err.err or err}" if err?
        notify.success "Document deleted"
        window.location.hash = "#/collection/#{name}"