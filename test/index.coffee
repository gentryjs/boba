should = require 'should'
boba = require '../lib/readDir'
path = require 'path'
rimraf = require 'rimraf'
walker = require 'easy-file-walker'

expected = require './data/scaffoldOutput'

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

    boba './test/templates', './test/boba', null,
      blacklist: ['.DS_Store']
      sandbox: sandbox
      recursive: true
      key:
        language: 'coffee'
        backend: 'yes'
        auth: 'facebook'
      , (err, res) ->
        # walk dir to compare to expected
        walker.walk './test/boba'
          .then (files) ->
            # sort to make order eql
            files.sort().should.eql expected.sort()
          # promise hack
          .then done.bind(null, null), done
