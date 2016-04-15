process.env.NODE_ENV = 'test'
fs = require 'fs'
path = require 'path'
parse = require '../src/parser'
scan = require '../src/scanner'
should = require 'should'
error = require '../src/error'

SYNTAX_ERROR_DIR = 'test/data/syntax-errors/'

error.quiet = true

checkFileForErrors = (name) ->
  check = name.replace(/-/g, ' ').replace(/\.roo$/, '')
  it check, (done) ->
    file = path.join(SYNTAX_ERROR_DIR, name)
    scan file, (tokens) ->
      priorErrorCount = error.count
      program = parse tokens
      error.count.should.be.above priorErrorCount
      done()

describe 'The parser detects an error for', ->
   for name in fs.readdirSync SYNTAX_ERROR_DIR
      checkFileForErrors(name)
      