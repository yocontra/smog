define ["smog/server", "smog/notify", "smog/editor", "templates/edit"], (server, notify, editor, templ) ->
  show: ({name, id}) ->
    val = $("##{id}-value").text()

    $('#content').html templ 
      title: "Editing #{id}"
      id: id
      button: 'Save'

    edit = editor.create "#{id}-edit-view",
      mode: "javascript"
      wrap: 100
      worker: false
      value: val

    $('#edit-button').click ->
      server.collection 
        collection: name
        type: 'update'
        query: edit.getText()
        (err) ->
          return notify.error "Error saving document: #{err.err or err}" if err?
          edit.destroy()
          notify.success "Document saved!"
          window.location.hash = "#/collection/#{name}"