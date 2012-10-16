define ->
  filterCollections: (collections) ->
    out = []
    for item in collections when item.name.indexOf('.system.') is -1
      name = item.name.substring item.name.indexOf('.') + 1
      out.push name
    return out

  filterDocuments: (docs) ->
    for doc in docs
      doc.created = @getCreated doc._id
      doc.size = @readableSize doc.size
    return docs

  readableSize: (size) ->
    units = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    i = 0
    while size >= 1024
      size /= 1024
      ++i
    return "#{Math.floor(size.toFixed(1))} #{units[i]}"

  getCreated: (id) ->
    de = "Unknown"
    return de unless id?
    try
      return prettyDate(parseInt(id.slice(0,8), 16)*1000) or de
    return de

  prettySeconds: (secs) ->
    days = Math.floor secs / 86400
    hours = Math.floor (secs % 86400) / 3600
    minutes = Math.floor ((secs % 86400) % 3600) / 60
    seconds = ((secs % 86400) % 3600) % 60
    out = ""
    out += "#{days} days " if days > 0
    out += "#{hours} hours " if hours > 0
    out += "#{minutes} minutes" if minutes > 0
    out += " #{seconds} seconds" if seconds > 0 and days <= 0 
    return out