fs        = require 'fs'
async     = require 'async'
whitelist = require './whitelist'
iterate   = require './iterate'

module.exports = (src, dest, opts, done) ->
 
  fs.readdir src, (err, files) ->
 
    if opts.blacklist?
      files = files.filter (file) -> 
        whitelist opts.blacklist, file 

    it = async.apply iterate, src, dest, opts
    async.forEach files, it, (done if done?)
