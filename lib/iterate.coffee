fs          = require 'fs'
path        = require 'path'
mkdirp      = require 'mkdirp'
merge       = require 'lodash.merge'
isDir       = require './isDir'
interpolate = require './interpolate'

module.exports = (baseSrc, baseDest, currentKey, opts, file, done) ->

  opts.keyChar ?= '^'
  opts.valChar ?= '@'

  src = path.join baseSrc, file
  dest = path.join baseDest, file

  if isDir src
    
    if file.charAt(0) is opts.valChar
      if opts.key[currentKey] is file.substring 1
        dest = baseDest # + '/' + file.substring 1
      else 
        return done()

    else if file.charAt(0) is opts.keyChar
      dest = baseDest
      currentKey = file.substring 1

    if fs.existsSync src
      mkdirp dest, (err) -> 
        require('./readDir') src, dest, currentKey, opts, done
  else

    if file.charAt(0) is opts.valChar
      ext = path.extname(file)
      keyname = path.basename file, ext
      keyname = keyname.substring 1
    
      if opts.key[currentKey] is keyname
        if ext is '.json'
          # read
          json = fs.readFileSync src
          data = interpolate json.toString(), opts.sandbox
          obj = JSON.parse data 
          # merge into package
          opts.pkg = merge opts.pkg, obj
          return done()
        else
          dest = baseDest + '/' + file.substring 1
      else
        return done()

    fs.readFile src, (err, template) ->
      data = interpolate template.toString(), opts.sandbox
      fs.writeFile dest, data, (err) ->
        console.log err if err?
        done()