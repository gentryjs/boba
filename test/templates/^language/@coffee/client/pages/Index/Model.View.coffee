fission = require '../../app'
Todo = require '../../models/Todo'
{div, h1, h3, a, button, br, span, input, img} = fission.React.DOM

module.exports = fission.modelView
  model: Todo
  remove: -> @model.destroy()
  toggle: ->
    @model.done = !@model.done
    @model.save()
  check: ->
    if @model.done
      return 'done'
    return 'notdone'
  render: ->

    @model = new Todo 
      text: 'foo'
      done: false

    div {className: 'item'},
      input {className: 'checkbox', type: 'checkbox', onClick: @toggle, defaultChecked: @model.done}
      span {className: @check()}, @model.text
      a {className: 'remove', href: '#', onClick: @remove}, ' x'