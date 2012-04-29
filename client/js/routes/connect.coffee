define ["smog/server", "templates/connect", "smog/notify"], (server, templ, notify) ->
  ->
    $('#content').append templ()
    $('#connect-modal').modal()

    $('#connect-form').on 'submit', (e) ->
      e.preventDefault()
      $('#connect-modal').modal 'hide'
      
      host = $('#host').val()
      port = parseInt $('#port').val()
      database = $('#database').val()

      server.connect host, port, database, (err, okay) ->
        if err?
          $('#connect-modal').modal 'show'
          notify.error "Connection error: #{err}"
        else
          window.location.hash = '#/home'