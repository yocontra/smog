define ["smog/server", "smog/notify", "smog/editor", "templates/edit"], (server, notify, editor, templ) ->
  ({name, id}) ->
    realname = name.toLowerCase()

    $('#content').append templ title: 'Edit', id: id
    edit = editor.create "#{id}-edit-view"
    edit.getSession().setUseWrapMode true
    edit.getSession().setWrapLimitRange 100, 100
    edit.getSession().setUseWorker false
    edit.getSession().setValue $("##{id}-value").text()

    $('#edit-modal').modal().css
      'margin-top': -> -($(@).height() / 2)
      'margin-left': -> -($(@).width() / 2)

    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()

    $('#edit-button').click ->
      try
        server.collection 
          collection: realname
          type: 'update'
          query: edit.getSession().getValue()
          (err) ->
            return notify.error "Error saving document: #{err}" if err?
            $('#edit-modal').modal 'hide'
            notify.success "Document saved!"
            window.location.hash = "#/collection/#{name}"
      catch err
        notify.error "Invalid JSON: #{err}"