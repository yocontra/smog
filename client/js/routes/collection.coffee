define ["smog/server", "smog/util", "smog/notify", "templates/collection", "templates/editbar"], (server, util, notify, templ, editbar) ->
  ({name}) ->
    realname = name.toLowerCase()
    
    server.collection 
      collection: realname
      type: 'find'
      query: "{}"
      options:
        limit: 1000
      (err, docs) ->
        return notify.error "Error retrieving documents: #{err}" if err?
        notify.alert "Document limit reached - only displaying first 1000" if docs.length >= 999
        
        $('#content').html templ 
          name: name
          documents: util.filterDocuments docs
        $('#editbar').html editbar name: name