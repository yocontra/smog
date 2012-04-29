define ["smog/server", "templates/connect", "smog/notify"], (server, templ, notify) ->
  ->
    $('#content').append templ()
    $('#connect-modal').modal().css
      'margin-left': -> -($(@).width() / 2)

    $('#connect-modal').on 'hidden', ->
      host = $('#host').val()
      port = parseInt $('#port').val()
      database = $('#database').val()

      server.connect host, port, database, (err, okay) ->
        if err?
          $('#connect-modal').modal 'toggle'
          notify.error "Connection error: #{err}"
        else
          window.location.hash = '#/home'