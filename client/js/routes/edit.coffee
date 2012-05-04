define ["smog/server", "smog/notify", "smog/editor", "templates/edit"], (server, notify, editor, templ) ->
  ({name, id}) ->
    realname = name.toLowerCase()

    $('#content').append templ 
      title: 'Edit'
      id: id
      button: 'Save'

    edit = editor.create "#{id}-edit-view",
      wrap: 100
      worker: false
      value: $("##{id}-value").text()
    
    $('#edit-modal').modal()
    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()

    $('#edit-button').click ->
      server.collection 
        collection: realname
        type: 'update'
        query: edit.getSession().getValue()
        (err) ->
          return notify.error "Error saving document: #{err}" if err?
          $('#edit-modal').modal 'hide'
          notify.success "Document saved!"
          window.location.hash = "#/collection/#{name}"