define ["smog/server", "smog/util", "smog/notify", "smog/editor", "templates/edit", "templates/collection"], (server, util, notify, editor, templ, collection) ->
  ({name}) ->
    realname = name.toLowerCase()

    $('#content').append templ 
      title: 'Find'
      id: realname
      button: 'Execute'
      
    edit = editor.create "#{realname}-edit-view",
      wrap: 100
      worker: false
    
    $('#edit-modal').modal()
    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()

    $('#edit-button').click ->
      $('#edit-modal').modal 'hide'
      server.collection 
        collection: realname
        type: 'find'
        query: query
        (err, docs) ->
          return notify.error "Error retrieving documents: #{err}" if err?
          
          $('#content').html collection 
            name: name
            documents: util.filterDocuments docs