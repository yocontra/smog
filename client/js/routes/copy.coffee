define ["smog/notify", "smog/editor", "templates/copy"], (notify, editor, templ) ->
  ({name, id}) ->
    realname = name.toLowerCase()

    $('#content').append templ id: id

    edit = editor.create "#{id}-copy-view", "json"
    edit.setReadOnly true
    edit.renderer.setShowGutter false
    edit.getSession().setUseWrapMode true
    edit.getSession().setWrapLimitRange 57, 57
    edit.getSession().setValue $("##{id}-value").text()

    $('#copy-modal').modal().css
      'margin-left': -> -($(@).width() / 2)

    $('#copy-modal').on 'hidden', ->
      edit.destroy()
      $('#copy-modal').remove()