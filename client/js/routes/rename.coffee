define ["smog/server", "templates/rename", "smog/notify"], (server, templ, notify) ->
  ({name}) ->
    $('#content').append templ()
    $('#rename-modal').modal().css
      'margin-left': -> -($(@).width() / 2)
    $('#rename-modal').on 'hidden', ->
      $('#rename-modal').remove()

    $('#rename-button').click ->
      server.collection
        collection: name.toLowerCase()
        type: 'rename'
        query: 
          name: $('#newname').val()
        (err) ->
          return notify.error "Error renaming collection: #{err}" if err?
          $('#rename-modal').modal 'hide'
          notify.success "Collection renamed"
          window.location.hash = '#/home'