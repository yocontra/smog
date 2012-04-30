define ["smog/server", "templates/confirm", "smog/notify"], (server, templ, notify) ->
  ({name}) ->
    $('#content').append templ
      title: 'Empty'
      text: 'Emptying a collection will remove every document it contains.\nYou will not be able to recover any data lost.'
   
    $('#confirm-modal').modal().css
      'margin-left': -> -($(@).width() / 2)
    $('#confirm-modal').on 'hidden', ->
      $('#confirm-modal').remove()

    $('#confirm-button').click ->
      server.collection
        collection: name.toLowerCase()
        type: 'empty'
        (err) ->
          return notify.error "Error emptying collection: #{err}" if err?
          $('#confirm-modal').modal 'hide'
          notify.success "Collection emptied"
          window.location.hash = '#/home'