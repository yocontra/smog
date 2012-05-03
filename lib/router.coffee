Vein = require 'vein'
async = require 'async'
{readdir} = require 'fs'
{join, basename, extname} = require 'path'

module.exports =
  initialize: (server, servicesDir, cb) ->
    vein = new Vein server
    readdir servicesDir, (err, files) ->
      return cb err if err?
      loadService = (file, cb) ->
        serviceName = basename file, extname file
        service = require join servicesDir, file
        vein.add serviceName, service
        cb()
      async.forEach files, loadService, cb