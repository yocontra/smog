define ["smog/server", "smog/notify", "smog/editor", "templates/edit"], (server, notify, editor, templ) ->
  ({name}) ->
    realname = name.toLowerCase()

    $('#content').append templ 
      title: 'Insert'
      id: realname
      button: 'Insert'
      
    edit = editor.create "#{realname}-edit-view",
      wrap: 100
      mode: "javascript"
      worker: false
      value: "{\r\n\r\n}"

    $('#edit-modal').modal()
    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()

    $('#edit-button').click ->
      server.collection 
        collection: realname
        type: 'insert'
        query: edit.getSession().getValue()
        (err) ->
          return notify.error "Error inserting document: #{err}" if err?
          $('#edit-modal').modal 'hide'
          notify.success "Document inserted!"
          window.location.hash = "#/collection/#{name}"