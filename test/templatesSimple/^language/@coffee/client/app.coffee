Fission = require 'fission'
sync = require 'fission-<%= answers.persistence %>'

fission = new Fission
  sync: sync
module.exports = fission