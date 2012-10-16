define ["smog/server", "templates/input", "smog/notify"], (server, templ, notify) ->
  show: ->
    $('#content').append templ
      title: 'New'
      button: 'Create'
      placeholder: 'Name'
      
    $('#input-modal').modal()
    $('#input-modal').on 'hidden', ->
      $('#input-modal').remove()

    $('#input-button').click ->
      server.createCollection $('#input-text').val(), {}, (err) ->
        return notify.error "Error creating collection: #{err.err or err}" if err?
        $('#input-modal').modal 'hide'
        notify.success "Collection created"
        window.location.hash = '#/home'