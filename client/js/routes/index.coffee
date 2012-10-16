define ["smog/server", "smog/notify", "templates/connect"], (server, notify, templ) ->
  show: ->
    $('#content').html templ()
    
    $('#connect-modal').modal backdrop: false
    $('#connect-button').click ->
      host = $('#host').val()

      server.connect host, (err, okay) ->
        if err?
          err = "Server unavailable" if typeof err is 'object' and Object.keys(err).length is 0
          notify.error "Connection error: #{err.err or err}"
        else
          $('#connect-modal').modal 'hide'
          window.location.hash = '#/home'