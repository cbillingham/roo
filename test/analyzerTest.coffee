fs = require 'fs'
path = require 'path'
should = require 'should'
scan = require '../src/scanner'
parse = require '../src/parser'
error = require '../src/error'

error.quiet = true

TEST_DIR = 'test/data/semantic-errors'

describe 'The analyzer detects an error for', () ->
  fs.readdirSync(TEST_DIR).forEach (name) ->
    check = name.replace(/-/g, ' ').replace(/\.iki$/, '')
    it check, (done) ->
      scan path.join(TEST_DIR, name), (tokens) ->
        priorErrorCount = error.count
        program = parse tokens
        error.count.should.equal priorErrorCount
        program.analyze()
        error.count.should.be.above priorErrorCount
        done()