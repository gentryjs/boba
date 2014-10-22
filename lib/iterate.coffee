fs          = require 'fs'
path        = require 'path'
mkdirp      = require 'mkdirp'
merge       = require 'lodash.merge'
isDir       = require './isDir'
interpolate = require './interpolate'

module.exports = (baseSrc, baseDest, currentKey, opts, file, done) ->

  opts.keyChar ?= '^'
  opts.valChar ?= '@'
  opts.varChar ?= '#'

  isKey = (file) -> return true if file.charAt(0) is opts.keyChar
  isVal = (file) -> return true if file.charAt(0) is opts.valChar
  isVar = (file) -> return true if file.charAt(0) is opts.varChar

  src = path.join baseSrc, file
  dest = path.join baseDest, file

  if isDir src
    
    # @
    if isVal file
      if opts.key[currentKey] is file.substring 1
        dest = baseDest # + '/' + file.substring 1
      else 
        return done()

    # ^
    else if isKey file
      dest = baseDest
      currentKey = file.substring 1

    # #
    else if isVar file 
      varname = file.substring 1
      dest = baseDest + '/' + opts.sandbox[varname]

    if fs.existsSync src
      mkdirp dest, (err) -> 
        require('./readDir') src, dest, currentKey, opts, done
  else

    # @
    if isVal file
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

    # #
    else if isVar file
      fileArr = file.split '.'
      varname = fileArr[0].substring 1
      fileArr[0] = opts.sandbox[varname] 
      filename = fileArr.join '.'
      dest = baseDest + '/' + filename

    fs.readFile src, (err, template) ->
      data = interpolate template.toString(), opts.sandbox
      fs.writeFile dest, data, (err) ->
        console.log err if err?
        done()