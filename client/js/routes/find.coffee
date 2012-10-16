define ["smog/server", "smog/util", "smog/notify", "smog/editor", "templates/edit", "templates/collection"], (server, util, notify, editor, templ, collection) ->
  show: ({name}) ->
    $('#content').html templ 
      title: 'Find'
      id: name
      button: 'Execute'
      
    edit = editor.create "#{name}-edit-view",
      mode: "javascript"
      wrap: 100
      worker: false
      value: "{\r\n\r\n}"

    $('#edit-button').click ->
      server.collection 
        collection: name
        type: 'find'
        query: edit.getText()
        (err, docs) ->
          return notify.error "Error retrieving documents: #{err.err or err}" if err?
          edit.destroy()
          $('#content').html collection 
            name: name
            documents: util.filterDocuments docs

          $('.dataPreview').click -> $(this).toggleClass "crop"