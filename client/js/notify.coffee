define ->
  notify = (text, type, pos="bottom") ->
    noty
      text: text
      theme: 'noty_theme_twitter'
      layout: pos
      type: type
      animateOpen:
        height: "toggle"
      animateClose:
        height: "toggle"
      speed: 500
      timeout: 3000
      closeButton: false
      closeOnSelfClick: true
      closeOnSelfOver: false
    return

  notify.error = (text, pos) -> notify text, 'error', pos
  notify.success = (text, pos) -> notify text, 'success', pos
  notify.info = (text, pos) -> notify text, 'information', pos
  notify.alert = (text, pos) -> notify text, 'alert', pos
  return notify