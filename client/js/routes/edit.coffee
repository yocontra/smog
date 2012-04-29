define ["smog/notify", "smog/editor", "templates/edit"], (notify, editor, templ) ->
  ({name, id}) ->
    realname = name.toLowerCase()

    $('#content').append templ id: id
    edit = editor.create "#{id}-edit-view", "json"
    edit.getSession().setUseWrapMode true
    edit.getSession().setWrapLimitRange 100, 100
    edit.getSession().setValue $("##{id}-value").text()

    $('#edit-modal').modal().css
      'margin-left': -> -($(@).width() / 2)

    $('#edit-modal').on 'hidden', ->
      edit.destroy()
      $('#edit-modal').remove()