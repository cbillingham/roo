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

   it 'correctly parses the fibonacci program', (done) ->
      scan 'test/data/parser/fibonacci.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.fibonacci
         done()

   it 'correctly parses the anonymous function', (done) ->
      scan 'test/data/parser/anonymousFunction.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.anonymousFun
         done()

   it 'correctly parses the list comprehension program', (done) ->
      scan 'test/data/parser/listComprehension.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.listComprehension
         done()

   it 'correctly parses collection literals', (done) ->
      scan 'test/data/parser/collections.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.collections
         done()

   it 'correctly parses map literals', (done) ->
      scan 'test/data/parser/mapLiterals.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.mapLiterals
         done()

   it 'correctly parses for loops', (done) ->
      scan 'test/data/parser/forLoop.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.forLoop
         done()

   it 'correctly parses the order of operations in the correct order', (done) ->
      scan 'test/data/parser/orderOfOps.roo', (tokens) ->
         program = parse tokens
         program.toString().should.equal expectedAST.orderOfOperations
         done()

   it 'correctly parses the prefix ops', (done) ->
         scan 'test/data/parser/prefixOp.roo', (tokens) ->
            program = parse tokens
            program.toString().should.equal expectedAST.prefixOp
            done()

   it 'correctly parses the postfix ops', (done) ->
         scan 'test/data/parser/prefixOp.roo', (tokens) ->
            program = parse tokens
            program.toString().should.equal expectedAST.postfixOp
            done()
