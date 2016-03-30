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
         i(tokens[21]).should.equal i {kind:'boollit',lexeme:'true',line:1,col:76}
         i(tokens[23]).should.equal i {kind:'boollit',lexeme:'false',line:1,col:81}
         i(tokens[24]).should.equal i {kind:'EOL',lexeme:'EOL'}
         i(tokens[25]).should.equal i {kind:'insist',lexeme:'insist',line:2,col:1}
         i(tokens[26]).should.equal i {kind:'nulllit',lexeme:'null',line:2,col:8}
         i(tokens[27]).should.equal i {kind:'id',lexeme:'nul',line:2,col:13}
         i(tokens[28]).should.equal i {kind:'EOL',lexeme:'EOL'}
         i(tokens[29]).should.equal i {kind:'EOF',lexeme:'EOF'}
         done()

   it 'properly handles comments and blank lines', (done) ->
      scan 'test/data/token-tests/comments-and-blank-lines', (tokens) ->
         i(tokens[9]).should.equal i {kind:'id', lexeme:'x', line:10,col:22}
         i(tokens[10]).should.equal i {kind:'=', lexeme:'=', line:10,col:24}
         i(tokens[11]).should.equal i {kind:'intlit', lexeme:'0', line:10,col:26}
         i(tokens[13]).should.equal i {kind:'EOF',lexeme:'EOF'}
         done()

   it 'reads symbolic tokens properly', (done) ->
      scan 'test/data/token-tests/symbols', (tokens) ->
         i(tokens[0]).should.equal i {kind:'<=', lexeme:'<=', line:1,col:1}
         i(tokens[1]).should.equal i {kind:'<', lexeme:'<', line:1, col:3}
         i(tokens[2]).should.equal i {kind:',', lexeme:',', line:1, col:4}
         i(tokens[3]).should.equal i {kind:'==', lexeme:'==', line:1, col:5}
         i(tokens[4]).should.equal i {kind:'=', lexeme:'=', line:1, col:7}
         i(tokens[5]).should.equal i {kind:'>=', lexeme:'>=', line:1, col:8}
         i(tokens[6]).should.equal i {kind:'>', lexeme:'>', line:1, col:10}
         i(tokens[7]).should.equal i {kind:'!=', lexeme:'!=', line:1, col:11}
         i(tokens[8]).should.equal i {kind:':', lexeme: ':', line:1, col:13}
         i(tokens[9]).should.equal i {kind:'(', lexeme: '(', line:1, col:14}
         i(tokens[10]).should.equal i {kind:')', lexeme: ')', line:1, col:15}
         i(tokens[11]).should.equal i {kind:'+', lexeme: '+', line:1, col:16}
         i(tokens[12]).should.equal i {kind:'-', lexeme: '-', line:1, col:17}
         i(tokens[13]).should.equal i {kind:'*', lexeme: '*', line:1, col:18}
         i(tokens[14]).should.equal i {kind:'/', lexeme: '/', line:1, col:19}
         i(tokens[15]).should.equal i {kind:'<', lexeme: '<', line:1, col:20}
         i(tokens[16]).should.equal i {kind:'>', lexeme: '>', line:1, col:21}
         i(tokens[17]).should.equal i {kind:'[', lexeme: '[', line:1, col:22}
         i(tokens[18]).should.equal i {kind:']', lexeme: ']', line:1, col:23}
         i(tokens[19]).should.equal i {kind:'{', lexeme: '{', line:1, col:24}
         i(tokens[20]).should.equal i {kind:'}', lexeme: '}', line:1, col:25}
         i(tokens[21]).should.equal i {kind:'**', lexeme: '**', line:1, col:26}
         i(tokens[22]).should.equal i {kind:'&&', lexeme: '&&', line:1, col:28}
         i(tokens[23]).should.equal i {kind:'||', lexeme: '||', line:1, col:30}
         i(tokens[24]).should.equal i {kind:'!', lexeme: '!', line:1, col:32}
         i(tokens[25]).should.equal i {kind:'.', lexeme: '.', line:1, col:33}
         i(tokens[27]).should.equal i {kind:'EOF',lexeme:'EOF'}
         done()

   it 'scans the simpliest program', (done) ->
      scan 'test/data/good-programs/helloworld.roo', (tokens) ->
         i(tokens[0]).should.equal i {kind:'id',lexeme:'print',line:1,col:1}
         i(tokens[1]).should.equal i {kind:'(', lexeme:'(',line:1,col:6}
         i(tokens[2]).should.equal i {kind:'stringlit',lexeme:'hello world',line:1,col:8}
         i(tokens[3]).should.equal i {kind:')', lexeme:')',line:1,col:20}
         i(tokens[5]).should.equal i {kind:'EOF',lexeme:'EOF'}
         done()

   it 'distinguishes between integers and floats', (done) ->
      scan 'test/data/token-tests/floats', (tokens) ->
         i(tokens[0]).should.equal i {kind:'intlit', lexeme:'100', line:1, col:1}
         i(tokens[1]).should.equal i {kind:'intlit', lexeme:'13', line:1, col:5}
         i(tokens[2]).should.equal i {kind:'floatlit', lexeme:'13.0', line:1, col:8}
         i(tokens[3]).should.equal i {kind:'floatlit', lexeme:'69.69', line:1, col:13}
         i(tokens[4]).should.equal i {kind:'intlit', lexeme:'14', line:1, col:19}
         i(tokens[5]).should.equal i {kind:'.', lexeme:'.', line:1, col:21}
         i(tokens[7]).should.equal i {kind:'EOF',lexeme:'EOF'}
         done()

   it 'recognizes valid floating point numbers', (done) ->
      scan 'test/data/good-programs/floating-point.roo', (tokens) ->
         i(tokens[0]).should.equal i {kind:'id', lexeme:'x', line:1, col:1}
         i(tokens[1]).should.equal i {kind:'=', lexeme:'=', line:1, col:3}
         i(tokens[2]).should.equal i {kind:'floatlit', lexeme:'4.35', line:1, col:5}
         i(tokens[3]).should.equal i {kind:'EOL',lexeme:'EOL'}
         i(tokens[4]).should.equal i {kind:'id', lexeme:'y', line:2, col:1}
         i(tokens[5]).should.equal i {kind:'=', lexeme:'=', line:2, col:3}
         i(tokens[6]).should.equal i {kind:'-', lexeme:'-', line:2, col:5}
         i(tokens[7]).should.equal i {kind:'floatlit', lexeme:'4.35', line:2, col:6}
         i(tokens[8]).should.equal i {kind:'EOL',lexeme:'EOL'}
         i(tokens[9]).should.equal i {kind:'id', lexeme:'z', line:3, col:1}
         i(tokens[10]).should.equal i {kind:'=', lexeme:'=', line:3, col:3}
         i(tokens[11]).should.equal i {kind:'floatlit', lexeme:'.35', line:3, col:5}
         i(tokens[12]).should.equal i {kind:'id', lexeme:'a', line:4, col:1}
         i(tokens[13]).should.equal i {kind:'EOL',lexeme:'EOL'}
         i(tokens[14]).should.equal i {kind:'=', lexeme:'=', line:4, col:3}
         i(tokens[15]).should.equal i {kind:'-', lexeme:'-', line:4, col:5}
         i(tokens[16]).should.equal i {kind:'floatlit', lexeme:'.35', line:4, col:6}
         i(tokens[17]).should.equal i {kind:'EOL',lexeme:'EOL'}
         i(tokens[18]).should.equal i {kind:'EOF',lexeme:'EOF'}
         done()