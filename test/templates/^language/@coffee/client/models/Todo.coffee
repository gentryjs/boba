fission = require '../app'

module.exports =

  fission.model
    props:
      id: 'integer'
      text: 'string'
      done: 'boolean'
    url: '/v1/todos'
