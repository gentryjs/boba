should = require 'should'
boba = require '../lib/read'
path = require 'path'
rimraf = require 'rimraf'

describe 'boba', ->

  after (done) ->
    rimraf path.resolve('./test/boba'), (err) -> 
      console.log err if err?
      done()
 
  it 'should parse and copy', (done) ->

    sandbox =
      name: 'boba'
      answers:
        persistence: 'REST'

    boba './test/templates', './test/boba',
      blacklist: ['.DS_Store']
      sandbox: sandbox
      recursive: true
      key:
        language: 'coffee'
        backend: 'yes'
      , (err, res) ->
        #TODO: include and check file 

        done()
