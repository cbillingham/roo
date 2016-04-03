# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require './scanner'
error = require './error'

Program             = require './entities/program'
Block               = require './entities/block'
AssignmentStatement = require './entities/assignment-statement'
WhileLoop           = require './entities/while-loop'
IfStatement         = require './entities/if-statement'

tokens = []
tokenTypes = ['id','if','loop','for','return','break','continue']

module.exports = (scannerOutput) ->
  tokens = scannerOutput
  program = parseProgram()
  match 'EOF'
  program

parseProgram = ->
  new Program(parseBlock())

parseBlock = ->
  statements= []
  loop
    statements.push parseStatement()
    break unless at tokenTypes
  new Block(statements)

parseStatement = ->
  if at 'id' or at 'global'
    parseAssignmentStatement()
  else if at 'while'
    parseWhileLoop()
  else if at 'if'
    parseIfStatement()
  else
    error 'Statement expected', tokens[0]

parseAssignmentStatement = ->
  if at 'global' 
    global = match 'global'
  identifier = new VariableReference(match 'id')
  match '='
  value = parseExpression()
  new AssignmentStatement(identifier, value, global) 
  
parseWhileLoop = ->
  match 'while'
  condition = parseExpression()
  body = parseBody()
  new WhileLoop(condition, body)

parseBody = ->
  match '{'
  parseBlock()
  match '}'

parseIfStatement = ->
  match 'if'
  condition = parseExpression()
  body = parseBody()
  elseifs = []
  while at 'else'
    match 'else'
    elseStatement = new elseStatement(parseBody())
    if at 'if'
      elseif = parseIfStatement
      elseifs.push elseif
   
  new IfStatement(condition, body, elseifs, else)

at = (kind) ->
  if tokens.length is 0
    false
  else if Array.isArray kind
    kind.some(at)
  else
    kind is tokens[0].kind

match = (kind) ->
  if tokens.length is 0
    error 'Unexpected end of source program'
  else if kind is undefined or kind is tokens[0].kind
    tokens.shift()
  else
    error "Expected \"#{kind}\" but found \"#{tokens[0].kind}\"", tokens[0]

parseExpression = ->
  #todo