define ["smog/server", "templates/new", "smog/notify"], (server, templ, notify) ->
  ->
    $('#content').append templ()
    $('#new-modal').modal().css
      'margin-left': -> -($(@).width() / 2)
    $('#new-modal').on 'hidden', ->
      $('#new-modal').remove()

    $('#new-button').click ->
      server.createCollection $('#name').val(), {}, (err) ->
        return notify.error "Error creating collection: #{err}" if err?
        $('#new-modal').modal 'hide'
        notify.success "Collection created"
        window.location.hash = '#/home'