interpolate = require './interpolate'
readDir = require './readDir'
fs = require 'fs'

module.exports = (src, dest, currentKey, opts, done) ->
    
  pkg = fs.readFileSync src + '/package.json'
  pkg = pkg.toString()
  pkg = interpolate pkg, opts.sandbox
  pkg = JSON.parse pkg

  opts.pkg = pkg

  readDir src, dest, currentKey, opts, ->

    # write out package

    pkg = JSON.stringify opts.pkg, null, 2

    fs.writeFile dest + '/package.json', pkg, (err) ->
      throw new Error err if err?
      done()