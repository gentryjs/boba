module.exports = function (blacklist, file) {
  var i, len, pattern
  for (i = 0, len = blacklist.length; i < len; i++) {
    pattern = blacklist[i]
    if (pattern instanceof RegExp) {
      if (pattern.test(file)) {
        return false
      }
    } else if (typeof pattern === 'string') {
      if (pattern === file) {
        return false
      }
    }
  }
  return true
}
