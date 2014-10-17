fission = require '../../app'
{div, h1} = fission.React.DOM



module.exports = ->
  fission.view
    render: ->
      div {className: 'content not-found'},
        h1 {}, "404 Not Found!"
