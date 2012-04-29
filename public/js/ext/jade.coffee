define [], ->
  # Escape the given string of html.
  escape = (html) -> String(html).replace(/&(?!\w+;)/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace /"/g, "&quot;"

  # Any template errors are passed to this
  rethrow = (err) -> throw err

  # Render the given attributes object.
  attrs = (obj) ->
    buf = []
    delete obj.terse

    for key, val of obj
      buf.push ""
      if val and typeof val is "boolean"
        buf.push "#{key}='#{key}'"
      else if key is "class" and Array.isArray val
        buf.push "#{key}='#{escape val.join(' ')}'"
      else
        buf.push "#{key}='#{escape(val)}'"
    return buf.join " "
  return escape: escape, rethrow: rethrow, attrs: attrs