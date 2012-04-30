define ["smog/server", "templates/connect", "smog/notify"], (server, templ, notify) ->
  ->
    $('#content').append templ()
    $('#connect-modal').modal().css
      'margin-left': -> -($(@).width() / 2)

    $('#connect-button').click ->
      host = $('#host').val()
      port = parseInt $('#port').val()
      database = $('#database').val()

      server.connect host, port, database, (err, okay) ->
        if err?
          notify.error "Connection error: #{err}"
        else
          $('#connect-modal').modal 'hide'
          window.location.hash = '#/home'