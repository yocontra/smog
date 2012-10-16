define ["smog/server", "smog/notify", "templates/confirm"], (server, notify, templ) ->
  show: ({name}) ->
    $('#content').append templ
      title: 'Drop'
      text: 'Dropping a collection will completely remove it from the database.\nYou will not be able to recover any data lost.'
   
    $('#confirm-modal').modal()
    $('#confirm-modal').on 'hidden', ->
      $('#confirm-modal').remove()

    $('#confirm-button').click ->
      server.collection
        collection: name
        type: 'drop'
        (err) ->
          return notify.error "Error dropping collection: #{err}" if err?
          $('#confirm-modal').modal 'hide'
          notify.success "Collection dropped"
          window.location.hash = '#/home'