define ["smog/server", "templates/confirm", "smog/notify"], (server, templ, notify) ->
  ({name}) ->
    $('#content').append templ
      title: 'Drop'
      text: 'Dropping a collection will completely remove it from the database.\nYou will not be able to recover any data lost.'
   
    $('#confirm-modal').modal().css
      'margin-left': -> -($(@).width() / 2)
    $('#confirm-modal').on 'hidden', ->
      $('#confirm-modal').remove()

    $('#confirm-button').click ->
      server.collection
        collection: name.toLowerCase()
        type: 'drop'
        (err) ->
          return notify.error "Error dropping collection: #{err}" if err?
          $('#confirm-modal').modal 'hide'
          notify.success "Collection dropped"
          window.location.hash = '#/home'