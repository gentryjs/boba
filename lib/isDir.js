const fs = require('fs')

module.exports = function (file) {
  return fs.statSync(file).isDirectory()
}
