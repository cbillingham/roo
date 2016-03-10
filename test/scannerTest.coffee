process.env.NODE_ENV = 'test';
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