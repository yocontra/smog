define ['ace/ace'], (ace) ->
  create: (el, {theme, mode, worker, wrap, tabSize, value, invisibles}) ->
    editor = ace.edit el
    editor.getSession().setUseSoftTabs true
    editor.setShowPrintMargin false
    editor.renderer.setHScrollBarAlwaysVisible false
    editor.renderer.setPrintMarginColumn false
    editor.renderer.setShowPrintMargin false
    editor.renderer.setAnimatedScroll true

    # defaults
    theme ?= "twilight"
    worker ?= true
    tabSize ?= 2
    invisibles ?= false

    editor.setTheme "ace/theme/#{theme}"
    editor.getSession().setUseWorker worker
    editor.getSession().setMode "ace/mode/#{mode}"
    editor.getSession().setValue value
    if wrap?
      editor.getSession().setUseWrapMode true
      editor.getSession().setWrapLimitRange wrap
    editor.renderer.setShowInvisibles invisibles

    # augment
    editor.getText = -> editor.getSession().getValue()
    return editor