fs          = require 'fs'
path        = require 'path'
mkdirp      = require 'mkdirp'
isDir       = require './isDir'
interpolate = require './interpolate'

module.exports = (baseSrc, baseDest, opts, file, done) ->

  src = path.join baseSrc, file
  dest = path.join baseDest, file

  if isDir src
    mkdirp dest, (err) -> 
      require('./read') src, dest, opts, done
  else
    fs.readFile src, (err, template) ->
      data = interpolate template.toString(), opts.sandbox
      fs.writeFile dest, data, (err) ->
        console.log err if err?
        done()