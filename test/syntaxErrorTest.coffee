process.env.NODE_ENV = 'test'
fs = require 'fs'
path = require 'path'
parse = require '../src/parser'
scan = require '../src/scanner'
should = require 'should'
error = require '../src/error'
{inspect: i} = require 'util'
expectedAST = require './data/parser/expected-output/asts'

SYNTAX_ERROR_DIR = 'test/data/syntax-errors'

error.quiet = true

describe 'The parser detects an error for', ->
   for name in fs.readdirSync SYNTAX_ERROR_DIR
      check = name.replace(/-/g, ' ').replace(/\.roo$/, '')
      console.log check
      it check, (done) ->
         scan path.join(SYNTAX_ERROR_DIR, name), (tokens) ->
            priorErrorCount = error.count
            parse tokens
            error.count.should.be.above priorErrorCount
            done()