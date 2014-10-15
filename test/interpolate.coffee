should = require 'should'
interpolate = require '../lib/interpolate'

describe 'interpolate', ->

  it 'should return empty if passed falsey value', ->

    result = interpolate '', 
      name: 'boba'
    result.should.equal ''

    result = interpolate null, 
      name: 'boba'
    result.should.equal ''


  it 'should return parsed template', ->

    template = "hi <%= name %>"
    result = interpolate template, 
      name: 'boba'
    result.should.equal 'hi boba'

    template = "hi <%= name.last %>"
    result = interpolate template, 
      name: 
        first: 'boba'
        last: 'fett'
    result.should.equal 'hi fett'
