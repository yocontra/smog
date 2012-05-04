getCreated = (id) -> prettyDate(parseInt(id.slice(0,8), 16)*1000) or "Unknown"

define ["smog/server", "smog/notify", "smog/editor", "templates/edit", "templates/collection"], (server, notify, editor, templ, grid) ->
  ({name}) ->
    realname = name.toLowerCase()

    find = (query, cb) ->
      server.collection 
        collection: realname
        type: 'find'
        query: query
        options: 
          limit: 10000
        (err, docs) ->
          return notify.error "Error retrieving documents: #{err}" if err?
          notify.alert "Document limit reached - only displaying first 10000" if docs.length >= 9999

          # clean up data
          doc.created = getCreated(doc._id) for doc, idx in docs
          $('#content').html grid name: name, documents: docs
          cb()

    setup = ->
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

    $('#content').append templ 
      title: 'Find'
      id: realname
      button: 'Execute'
      
    edit = editor.create "#{realname}-edit-view",
      wrap: 100
      worker: false
    
    $('#edit-modal').modal()
    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()

    $('#edit-button').click ->
      $('#edit-modal').modal 'hide'
      find edit.getSession().getValue(), setup