fission = require '../app'

module.exports =

  fission.model
    props:
      id: 'string'
    url: '/v1/<%= model %>'
