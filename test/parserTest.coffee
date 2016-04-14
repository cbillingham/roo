process.env.NODE_ENV = 'test'
parse = require '../src/parser'
scan = require '../src/scanner'
should = require 'should'
error = require '../src/error'
{inspect: i} = require 'util'
expectedAST = require './data/parser/expected-output/asts'
  
describe 'The parser', ->

   it 'correctly parses simple assignment statements', (done) ->
      scan 'test/data/good-programs/simple-assignment.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.assignmentStatements
         done()

   it 'correctly parses an empty program', (done) ->
      scan 'test/data/parser/empty.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.empty
         done()

   it 'correctly parses the gcd program', (done) ->
      scan 'test/data/parser/gcd.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.gcd
         done()

   it 'correctly parses the countdown program', (done) ->
      scan 'test/data/parser/countdown.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.countdown
         done()

   it 'correctly parses a while loop program', (done) ->
      scan 'test/data/good-programs/while-loop.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.whileLoop
         done()

   it 'correctly parses object instantiation', (done) ->
      scan 'test/data/good-programs/object-instantiation.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.objects
         done()

   it 'correctly parses lambda functions', (done) ->
      scan 'test/data/good-programs/lambda.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.lambdas
         done()