define ["smog/server", "smog/util", "smog/notify", "smog/editor", "templates/edit", "templates/collection"], (server, util, notify, editor, templ, collection) ->
  show: ({name}) ->
    $('#content').html templ 
      title: 'Map Reduce'
      id: name
      button: 'Execute'
      
    edit = editor.create "#{name}-edit-view",
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

    $('#edit-button').click ->
      server.collection 
        collection: name
        type: 'mapReduce'
        query: edit.getText()
        (err, docs, stat) ->
          return notify.error "Error retrieving documents: #{err.err or err}" if err?
          edit.destroy()
          $('#content').html collection 
            name: name
            documents: util.filterDocuments docs