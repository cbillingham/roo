# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require './scanner'
error = require './error'

Program             = require './entities/program'
Block               = require './entities/block'
AssignmentStatement = require './entities/assignment-statement'

tokens = []
tokenTypes = ['var', 'id','if','loop','for','return','break','continue']

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
    parseWhileStatement()
  else
    error 'Statement expected', tokens[0]

parseAssignmentStatement = ->
  if at 'global' 
    global = match 'global'
  identifier = new VariableReference(match 'id')
  match '='
  value = parseExpression()
  new AssignmentStatement(identifier, value, global) 
  
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