require('should')
const boba = require('../lib')
const path = require('path')
const rimraf = require('rimraf')
const walker = require('easy-file-walker')
const expected = require('./data/commandOutput')

module.exports = {
  after: function (done) {
    return rimraf(path.resolve('./test/command'), function (err) {
      if (err != null) {
        console.log(err)
      }
      return done()
    })
  },

  'command shuld': {
    'should parse and copy': function (done) {
      var sandbox
      sandbox = {
        model: 'Todo',
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
        src: './test/commandTemplates',
        dest: './test/command',
        currentKey: null,
        opts: {
          blacklist: ['.DS_Store'],
          sandbox: sandbox,
          key: {
            language: 'coffee',
            server: 'yes',
            auth: 'facebook'
          }
        }
      }, function (err, res) {
        if (err) console.log(err)
        return walker.walk('./test/command').then(function (files) {
          return files.sort().should.eql(expected.sort())
        }).then(done.bind(null, null), done)
      })
    }
  }
}
