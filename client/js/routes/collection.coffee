define ["smog/server", "templates/collection", "smog/notify"], (server, templ, notify) ->
  ({name, task}) ->
    realname = name.toLowerCase()
    
    findAll = (cb) ->
      server.collection 
        collection: realname
        type: 'find'
        query: {}
        (err, docs) ->
          return notify.error "Error retrieving documents: #{err}" if err?
          # clean up data
          formatted = ({id:doc._id,value:doc} for doc in docs)
          delete doc.value._id for doc in formatted
          doc.value = JSON.stringify doc.value for doc in formatted

          $('#content').html templ name: name, documents: formatted
          cb()

    handleChange = (value) ->
      try
        val = JSON.parse value
        val._id = @getAttribute 'id'
        server.collection 
          collection: realname
          type: 'update'
          query: val
          (err) ->
            return notify.error "Error saving document: #{err}" if err?
            notify.success "Document saved!"
        return value
      catch err
        notify.error "Invalid JSON: #{err}"

    setup = ->
      # Set up datagrid
      $('#datagrid').dataTable
        sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
        sPaginationType: "bootstrap"
        oLanguage:
            sLengthMenu: "_MENU_ records per page"

      $('.editable_textarea').editable handleChange,
        type: 'textarea'
        style: 'inherit'
        submit: 'Save'
        cancel: 'Cancel'
        indicator: 'Saving...'
        tooltip: 'Click to edit'

    findAll setup