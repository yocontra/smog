define ["smog/server", "templates/login", "smog/notify"], (server, templ, notify) ->
  ->
    $('#content').html templ()
    $('#login').on 'submit', (e) ->
      e.preventDefault()

      host = $('#host').val()
      port = parseInt $('#port').val()
      database = $('#database').val()
      server.connect host, port, database, (err, okay) ->
        if err?
          notify.error "Connection error: #{err}"
        else
          notify.success 'Connection established!'
          window.location.hash = '#/home'