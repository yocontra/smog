define ["smog/server", "templates/connect", "smog/notify"], (server, templ, notify) ->
  ->
    $('#content').html templ()
    $('#connect').on 'submit', (e) ->
      e.preventDefault()

      host = $('#host').val()
      port = parseInt $('#port').val()
      database = $('#database').val()
      server.connect host, port, database, (err, okay) ->
        if err?
          notify.error "Connection error: #{err}"
        else
          window.location.hash = '#/home'