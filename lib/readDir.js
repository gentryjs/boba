const fs = require('fs')
const async = require('async')
const whitelist = require('./whitelist')
const iterate = require('./iterate')

module.exports = function ({src, dest, currentKey, opts}, done) {
  return fs.readdir(src, function (err, files) {
    if (err != null) {
      throw new Error(err)
    }
    if (opts.blacklist != null) {
      files = files != null ? files.filter(function (file) {
        return whitelist(opts.blacklist, file)
      }) : void 0
    }
    const it = async.apply(iterate, {baseSrc: src, baseDest: dest, currentKey, opts})
    return async.forEach(files, it, done)
  })
}
