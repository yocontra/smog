define ["smog/server", "templates/input", "smog/notify"], (server, templ, notify) ->
  ({name}) ->
    $('#content').append templ
      title: 'Rename'
      button: 'Rename'
      placeholder: 'New name'
      
    $('#input-modal').modal()
    $('#input-modal').on 'hidden', ->
      $('#input-modal').remove()

    $('#input-button').click ->
      server.collection
        collection: name.toLowerCase()
        type: 'rename'
        query: 
          name: $('#input-text').val()
        (err) ->
          return notify.error "Error renaming collection: #{err}" if err?
          $('#input-modal').modal 'hide'
          notify.success "Collection renamed"
          window.location.hash = '#/home'