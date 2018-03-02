should = require 'should'
boba = require '../lib'
path = require 'path'
rimraf = require 'rimraf'
walker = require 'easy-file-walker'

expected = require './data/commandOutput'

describe 'command', ->

  after (done) ->
    rimraf path.resolve('./test/command'), (err) ->
      console.log err if err?
      done()

  it 'should parse and copy', (done) ->

    sandbox =
      model: 'Todo'
      answers:
        persistence: 'REST'
        auth: 'facebook'
      package:
        name: 'myapp'
        description: 'foo'
        org: 'wearefractal'
        author: 'fractal'

    boba
      src: './test/commandTemplates'
      dest: './test/command'
      currentKey: null
      opts:
        blacklist: ['.DS_Store']
        sandbox: sandbox
        key:
          language: 'coffee'
          server: 'yes'
          auth: 'facebook'
    , (err, res) ->
      # walk dir to compare to expected
      walker.walk './test/command'
        .then (files) ->
          # sort to make order eql
          files.sort().should.eql expected.sort()

        # promise hack
        .then done.bind(null, null), done
