define ['ace/ace'], ->
  # TODO: abstract settings into object
  create: (el, {mode, worker, wrap, tabSize, value}) ->
    editor = ace.edit el
    editor.setTheme "ace/theme/clouds_midnight"
    editor.getSession().setUseSoftTabs true
    editor.setShowPrintMargin false
    editor.renderer.setHScrollBarAlwaysVisible false
    editor.renderer.setPrintMarginColumn false
    editor.renderer.setShowPrintMargin false
    editor.renderer.setAnimatedScroll true
    editor.renderer.setShowInvisibles false

    mode ?= "javascript"
    worker ?= true
    value ?= "{\r\n\r\n}"
    tabSize ?= 2
    
    editor.getSession().setUseWorker worker
    editor.getSession().setMode "ace/mode/#{mode}"
    editor.getSession().setValue value
    if wrap?
      editor.getSession().setUseWrapMode true
      editor.getSession().setWrapLimitRange wrap
    return editor