require('should')
const interpolate = require('../lib/interpolate')

describe('interpolate', function () {
  it('should return empty if passed falsey value', function () {
    var result
    result = interpolate('', {
      name: 'boba'
    })
    result.should.equal('')
    result = interpolate(null, {
      name: 'boba'
    })
    return result.should.equal('')
  })

  it('should return parsed template', function () {
    let template = 'hi <%= name %>'
    let result = interpolate(template, {
      name: 'boba'
    })
    result.should.equal('hi boba')
    template = 'hi <%= name.last %>'
    result = interpolate(template, {
      name: {
        first: 'boba',
        last: 'fett'
      }
    })
    return result.should.equal('hi fett')
  })
})
