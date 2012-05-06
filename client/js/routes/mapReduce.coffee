define ["smog/server", "smog/util", "smog/notify", "smog/editor", "templates/edit", "templates/collection"], (server, util, notify, editor, templ, collection) ->
  ({name}) ->
    realname = name.toLowerCase()

    $('#content').append templ 
      title: 'Map Reduce'
      id: realname
      button: 'Execute'
      
    edit = editor.create "#{realname}-edit-view",
      mode: "javascript"
      worker: false
      wrap: 100
      value: """
        //This is a simple map/reduce that counts documents by name
        {
          map: function () {
            emit(this.name, {count: 1});
          },
          reduce: function (key, values) {
            var result = 0;
            values.forEach(function (value) {
              result += value.count;
            });
            return {count: result};
          }
        }
        """
    
    $('#edit-modal').modal()
    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()

    $('#edit-button').click ->
      $('#edit-modal').modal 'hide'
      server.collection 
        collection: realname
        type: 'mapReduce'
        query: edit.getSession().getValue()
        (err, docs, stat) ->
          return notify.error "Error retrieving documents: #{err}" if err?
          
          console.log docs, stat
          $('#content').html collection 
            name: name
            documents: util.filterDocuments docs