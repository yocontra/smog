define ["smog/notify", "smog/editor", "templates/copy"], (notify, editor, templ) ->
  ({name, id}) ->
    realname = name.toLowerCase()

    $('#content').append templ
      id: id
      name: realname
      value: $("##{id}-value").text()

    edit = editor.create "#{id}-copy-view", "json"
    #env.editor.renderer.setShowGutter false
    $('#copy-modal').modal 'show'
    $('#copy-modal').on 'shown', ->
      edit.resize()

    $('#copy-modal').on 'hidden', ->
      $('#copy-modal').remove()