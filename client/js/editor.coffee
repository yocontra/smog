define ->
  create: (el, mode) ->
    editor = ace.edit el
    editor.setTheme "ace/theme/clouds_midnight"
    if mode?
      editor.getSession().setMode "ace/mode/#{mode}"
    return editor