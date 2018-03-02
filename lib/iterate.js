const fs = require('fs')
const path = require('path')
const mkdirp = require('mkdirp')
const {merge} = require('lodash')
const isDir = require('./isDir')
const interpolate = require('./interpolate')

function getDefault (val, defaultVal) {
  if (val === undefined || val === null) {
    return defaultVal
  } else {
    return val
  }
}

module.exports = function ({baseSrc, baseDest, currentKey, opts}, file, done) {
  opts.keyChar = getDefault(opts.keyChar, '^')
  opts.valChar = getDefault(opts.valChar, '@')
  opts.varChar = getDefault(opts.varChar, '#')

  function isKey (file) {
    if (file.charAt(0) === opts.keyChar) {
      return true
    }
  }

  function isVal (file) {
    if (file.charAt(0) === opts.valChar) {
      return true
    }
  }

  function isVar (file) {
    if (file.charAt(0) === opts.varChar) {
      return true
    }
  }

  let src = path.join(baseSrc, file)
  let dest = path.join(baseDest, file)

  if (isDir(src)) {
    if (isVal(file)) {
      if (opts.key[currentKey] === file.substring(1)) {
        dest = baseDest
      } else {
        return done()
      }
    } else if (isKey(file)) {
      dest = baseDest
      currentKey = file.substring(1)
    } else if (isVar(file)) {
      const varname = file.substring(1)
      dest = baseDest + '/' + opts.sandbox[varname]
    }

    if (fs.existsSync(src)) {
      return mkdirp(dest, function (err) {
        if (err) console.log(err)
        return require('./readDir')({
          src: src,
          dest: dest,
          currentKey: currentKey,
          opts: opts
        }, done)
      })
    }
  } else {
    if (isVal(file)) {
      const ext = path.extname(file)
      let keyname = path.basename(file, ext)
      keyname = keyname.substring(1)
      if (opts.key[currentKey] === keyname) {
        if (ext === '.json') {
          const json = fs.readFileSync(src)
          const data = interpolate(json.toString(), opts.sandbox)
          const obj = JSON.parse(data)
          opts.pkg = merge(opts.pkg, obj)
          return done()
        } else {
          dest = baseDest + '/' + file.substring(1)
        }
      } else {
        return done()
      }
    } else if (isVar(file)) {
      const fileArr = file.split('.')
      const varname = fileArr[0].substring(1)
      fileArr[0] = opts.sandbox[varname]
      const filename = fileArr.join('.')
      dest = baseDest + '/' + filename
    }

    return fs.readFile(src, function (err, template) {
      if (err) console.log(err)
      const data = interpolate(template.toString(), opts.sandbox)
      return fs.writeFile(dest, data, function (err) {
        if (err != null) {
          console.log(err)
        }
        return done()
      })
    })
  }
}
