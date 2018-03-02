const interpolate = require('./interpolate')
const readDir = require('./readDir')
const fs = require('fs')

module.exports = function ({src, dest, currentKey, opts}, done) {
  if (opts.parsePackage) {
    let pkg = fs.readFileSync(src + '/package.json')
    pkg = pkg.toString()
    pkg = interpolate(pkg, opts.sandbox)
    pkg = JSON.parse(pkg)
    opts.pkg = pkg
  }

  return readDir({src, dest, currentKey, opts}, function () {
    if (opts.parsePackage) {
      let pkg = JSON.stringify(opts.pkg, null, 2)
      return fs.writeFile(dest + '/package.json', pkg, function (err) {
        if (err != null) {
          throw new Error(err)
        }
        return done()
      })
    } else {
      return done()
    }
  })
}
