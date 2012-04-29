define ->
  # TODO: abstract settings into object
  create: (el, mode) ->
    editor = ace.edit el
    editor.setTheme "ace/theme/clouds_midnight"
    editor.getSession().setMode "ace/mode/#{mode}" if mode?
    editor.getSession().setTabSize 2
    editor.getSession().setUseSoftTabs true
    editor.setShowPrintMargin false
    editor.renderer.setHScrollBarAlwaysVisible false
    editor.renderer.setPrintMarginColumn false
    editor.renderer.setShowPrintMargin false
    editor.renderer.setAnimatedScroll true
    editor.renderer.setShowInvisibles false
    return editor