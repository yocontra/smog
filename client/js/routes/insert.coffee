define ["smog/server", "smog/notify", "smog/editor", "templates/edit"], (server, notify, editor, templ) ->
  show: ({name}) ->
    $('#content').html templ 
      title: 'Insert'
      id: name
      button: 'Insert'
      
    edit = editor.create "#{name}-edit-view",
      mode: "javascript"
      wrap: 100
      worker: false
      value: "{\r\n\r\n}"

    $('#edit-button').click ->
      server.collection 
        collection: name
        type: 'insert'
        query: edit.getText()
        (err) ->
          return notify.error "Error inserting document: #{err.err or err}" if err?
          edit.destroy()
          notify.success "Document inserted!"
          window.location.hash = "#/collection/#{name}"