# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require './scanner'
error = require './error'

Program = require './entities/program'
Block = require './entities/block'

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
    match 'global'
  match 'id'
  match '='
  value = parseExpression()
  new AssignmentStatement(target, source, global) 
  
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
  left = parseExp1()
  while at 'or'
    op = match()
    right = parseExp1()
    left = new BinaryExpression(op, left, right)
  left

parseExp1 = ->
  left = parseExp2()
  while at 'and'
    op = match()
    right = parseExp2()
    left = new BinaryExpression(op, left, right)
  left

parseExp2 = ->
  left = parseExp3()
  if at ['<','<=','==','!=','>=','>']
    op = match()
    right = parseExp3()
    left = new BinaryExpression(op, left, right)
  left

parseExp3 = ->
  left = parseExp4()
  while at ['+','-']
    op = match()
    right = parseExp4()
    left = new BinaryExpression(op, left, right)
  left

parseExp4 = ->
  left = parseExp5()
  while at ['*','/']
    op = match()
    right = parseExp5()
    left = new BinaryExpression(op, left, right)
  left

parseExp5 = ->
  if at ['-','not']
    op = match()
    operand = parseExp6()
    new UnaryExpression(op, operand)
  else
    parseExp6()

parseExp6 = ->
  if at ['true','false']
    new BooleanLiteral(match().lexeme)
  else if at 'intlit'
    new IntegerLiteral(match().lexeme)
  else if at 'id'
    new VariableReference(match())
  else if at '('
    match()
    expression = parseExpression()
    match ')'
    expression
  else
    error 'Illegal start of expression', tokens[0]