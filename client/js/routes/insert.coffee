define ["smog/server", "smog/notify", "smog/editor", "templates/edit"], (server, notify, editor, templ) ->
  ({name}) ->
    realname = name.toLowerCase()

    $('#content').html templ 
      title: 'Insert'
      id: realname
      button: 'Insert'
      
    edit = editor.create "#{realname}-edit-view",
      mode: "javascript"
      wrap: 100
      worker: false
      value: "{\r\n\r\n}"

    $('#edit-button').click ->
      server.collection 
        collection: realname
        type: 'insert'
        query: edit.getText()
        (err) ->
          return notify.error "Error inserting document: #{err.err or err}" if err?
          edit.destroy()
          notify.success "Document inserted!"
          window.location.hash = "#/collection/#{name}"