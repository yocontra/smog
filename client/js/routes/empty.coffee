define ["smog/server", "smog/notify", "templates/confirm"], (server, notify, templ) ->
  show: ({name}) ->
    $('#content').append templ
      title: 'Empty'
      text: 'Emptying a collection will remove every document it contains.\nYou will not be able to recover any data lost.'
   
    $('#confirm-modal').modal()
    $('#confirm-modal').on 'hidden', ->
      $('#confirm-modal').remove()

    $('#confirm-button').click ->
      server.collection
        collection: name
        type: 'empty'
        (err) ->
          return notify.error "Error emptying collection: #{err.err or err}" if err?
          $('#confirm-modal').modal 'hide'
          notify.success "Collection emptied"
          window.location.hash = "#/collection/#{name}"