process.env.NODE_ENV = 'test'
scan = require '../src/scanner'
should = require 'should'
error = require '../src/error'
{inspect: i} = require 'util'
  
describe 'The scanner', ->

   it 'distinguishes reserved words and identifiers', (done) ->
      scan 'test/data/token-tests/words', (tokens) ->
         i(tokens[0]).should.equal i {kind:'id',lexeme:'whilexy',line:1,col:1}
         i(tokens[1]).should.equal i {kind:'while',lexeme:'while',line:1,col:9}
         i(tokens[2]).should.equal i {kind:'id',lexeme:'whil',line:1,col:15}
         i(tokens[3]).should.equal i {kind:'id',lexeme:'end',line:1,col:20}
         i(tokens[4]).should.equal i {kind:'loop',lexeme:'loop',line:1,col:24}
         i(tokens[5]).should.equal i {kind:'id',lexeme:'var',line:1,col:29}
         i(tokens[6]).should.equal i {kind:'and',lexeme:'and',line:1,col:33}
         i(tokens[7]).should.equal i {kind:'or',lexeme:'or',line:1,col:37}
         i(tokens[8]).should.equal i {kind:'id',lexeme:'ore',line:1,col:40}
         i(tokens[9]).should.equal i {kind:'id',lexeme:'not',line:1,col:44}
         i(tokens[11]).should.equal i {kind:'id',lexeme:'intbool',line:1,col:48}
         i(tokens[13]).should.equal i {kind:'id',lexeme:'int',line:1,col:56}
         i(tokens[15]).should.equal i {kind:'id',lexeme:'bool',line:1,col:60}
         i(tokens[17]).should.equal i {kind:'id',lexeme:'read',line:1,col:65}
         i(tokens[19]).should.equal i {kind:'id',lexeme:'write',line:1,col:70}
         i(tokens[21]).should.equal i {kind:'true',lexeme:'true',line:1,col:76}
         i(tokens[23]).should.equal i {kind:'false',lexeme:'false',line:1,col:81}
         done()

   it 'properly handles comments and blank lines', (done) ->
      scan 'test/data/token-tests/comments-and-blank-lines', (tokens) ->
         i(tokens[0]).should.equal i {kind:'id', lexeme:'x', line:10,col:1}
         i(tokens[1]).should.equal i {kind:'=', lexeme:'=', line:10,col:3}
         i(tokens[2]).should.equal i {kind:'intlit', lexeme:'0', line:10,col:5}
         done()

   # it 'reads symbolic tokens properly', (done) ->
   #    scan 'test/data/token-tests/symbols', (tokens) ->
   #       i(tokens[0]).should.equal i {kind:'<=', lexeme:'<=', line:1,col:1}
   #       done()

   # it 'scans the simpliest program', (done) ->
   #    scan 'test/data/good-programs/helloworld.roo', (tokens) ->
   #       i(tokens[0]).should.equal i {kind:'id',lexeme:'print',line:1,col:1}
   #       i(tokens[1]).should.equal i {kind:'(', lexeme:'(',line:1,col:6}
   #       i(tokens[2]).should.equal i {kind:'strlit',lexeme:'helloworld',line:1,col:8}
   #       done()

   it 'recognizes valid floating point numbers', (done) ->
      scan 'test/data/good-programs/floating-point.roo', (tokens) ->
         i(tokens[0]).should.equal i {kind:'id', lexeme:'x', line:1, col:1}
         i(tokens[1]).should.equal i {kind:'=', lexeme:'=', line:1, col:2}
         i(tokens[2]).should.equal i {kind:'floatlit', lexeme:'4.325', line:1, col:3}
         i(tokens[3]).should.equal i {kind:'id', lexeme:'y', line:2, col:1}
         i(tokens[3]).should.equal i {kind:'=', lexeme:'=', line:2, col:2}
         i(tokens[4]).should.equal i {kind:'-', lexeme:'-', line:2, col:3}
         i(tokens[5]).should.equal i {kind:'floatlit', lexeme:'4.325', line:2, col:4}
         i(tokens[6]).should.equal i {kind:'id', lexeme:'z', line:3, col:1}
         i(tokens[7]).should.equal i {kind:'=', lexeme:'=', line:3, col:3}
         i(tokens[8]).should.equal i {kind:'floatlit', lexeme:'.35', line:3, col:5}
         i(tokens[9]).should.equal i {kind:'id', lexeme:'a', line:4, col:1}
         i(tokens[10]).should.equal i {kind:'=', lexeme:'=', line:4, col:3}
         i(tokens[11]).should.equal i {kind:'-', lexeme:'-', line:4, col:5}
         i(tokens[12]).should.equal i {kind:'floatlit', lexeme:'.35', line:4, col:6}