require('should')
const boba = require('../lib')
const path = require('path')
const rimraf = require('rimraf')
const walker = require('easy-file-walker')
const expected = require('./data/scaffoldOutput')

module.exports = {
  after: function (done) {
    return rimraf(path.resolve('./test/boba'), function (err) {
      if (err != null) {
        console.log(err)
      }
      return done()
    })
  },

  scaffold: {
    'should parse and copy': function (done) {
      var sandbox
      sandbox = {
        answers: {
          persistence: 'REST',
          auth: 'facebook'
        },
        package: {
          name: 'myapp',
          description: 'foo',
          org: 'wearefractal',
          author: 'fractal'
        }
      }

      return boba({
        src: './test/templates',
        dest: './test/boba',
        currentKey: null,
        opts: {
          blacklist: ['.DS_Store'],
          parsePackage: true,
          sandbox: sandbox,
          key: {
            language: 'coffee',
            server: 'yes',
            auth: 'facebook'
          }
        }
      }, function (err, res) {
        if (err) console.log(err)
        return walker.walk('./test/boba').then(function (files) {
          return files.sort().should.eql(expected.sort())
        }).then(done.bind(null, null), done)
      })
    }
  }
}
