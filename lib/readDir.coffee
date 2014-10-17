fs        = require 'fs'
async     = require 'async'
whitelist = require './whitelist'
iterate   = require './iterate'
interpolate = require './interpolate'

module.exports = (src, dest, currentKey, opts, done) ->

  fs.readdir src, (err, files) ->

    throw new Error err if err?

    if opts.blacklist?
      files = files?.filter (file) -> 
        whitelist opts.blacklist, file 

    it = async.apply iterate, src, dest, currentKey, opts
    async.forEach files, it, (done if done?)
