fs = require 'fs'

module.exports = (file) -> 
  fs.statSync(file).isDirectory()