getCreated = (id) -> prettyDate(parseInt(id.slice(0,8), 16)*1000) or "Unknown"

define ["smog/server", "templates/collection", "templates/editbar", "smog/notify"], (server, templ, editbar, notify) ->
  ({name}) ->
    realname = name.toLowerCase()
    
    findAll = (cb) ->
      server.collection 
        collection: realname
        type: 'find'
        query: "{}"
        options: 
          limit: 1000
        (err, docs) ->
          # TODO: return one set of docs
          return notify.error "Error retrieving documents: #{err}" if err?
          notify.alert "Document limit reached - only displaying first 1000" if docs.length >= 999

          # clean up data
          doc.created = getCreated(doc._id) for doc, idx in docs
          $('#content').html templ name: name, documents: docs
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
        oLanguage:
          sSearch: ""
          sLengthMenu: "_MENU_ records per page"
    findAll setup