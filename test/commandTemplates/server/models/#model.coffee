{Schema} = require 'mongoose'

module.exports = new Schema

  id:
    type: String
    required: true
    index:
      unique: true