getCreated = (id) -> prettyDate(parseInt(id.slice(0,8), 16)*1000) or "Unknown"

define ["smog/server", "templates/collection", "templates/editbar", "smog/notify"], (server, templ, editbar, notify) ->
  ({name}) ->
    realname = name.toLowerCase()
    
    findAll = (cb) ->
      server.collection 
        collection: realname
        type: 'find'
        query: {}
        options: 
          limit: 1000
        (err, docs) ->
          return notify.error "Error retrieving documents: #{err}" if err?
          notify.alert "Document limit reached - only displaying first 1000" if docs.length >= 999
          # clean up data
          formatted = ({id:doc._id,value:doc,created:getCreated(doc._id)} for doc in docs)
          delete doc.value._id for doc in formatted
          doc.value = JSON.stringify doc.value, null, 2 for doc in formatted
          $('#content').html templ name: name, documents: formatted
          cb()

    setup = ->
      $('#editbar').html editbar name: name
      # Set up datagrid
      $('#datagrid').dataTable
        sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
        sPaginationType: "bootstrap"
        sScrollX: "100%"
        bScrollCollapse: true
        bStateSave: true
        bAutoWidth: true

    findAll setup