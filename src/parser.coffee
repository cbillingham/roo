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
ReturnStatement     = require './entities/return-statement'

errors
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
    match 'EOL'
    break unless at tokenTypes
  new Block(statements)

parseStatement = ->
  if at ['while','loop']
    parseWhileLoop()
  else if at 'for'
    parseForLoop()
  else if at 'if'
    parseIfStatement()
  else if at 'return'
    parseReturnStatement()
  else if at 'continue'
    parseContinueStatement()
  else if at 'break'
    parseBreakStatement()
  else
    parseExpression()

parseAssignmentStatement = ->
  if at 'global'
    global = match 'global'
  if at 'const'
    constant = match 'const'
    if at 'global'
      global = match 'global'
  identifier = new VariableReference(match 'id')
  match '='
  value = parseExpression()
  new AssignmentStatement(identifier, value, global, constant)
  
parseWhileLoop = ->
  match 'while'
  condition = parseExpression()
  body = parseBody()
  new WhileLoop(condition, body)

parseBody = ->
  match '{'
  match 'EOL' if at 'EOL'
  body = parseBlock()
  match '}'
  match 'EOL'
  body

parseReturnStatement = ->
  match 'return'
  new ReturnStatement parseExpression()

parseIfStatement = ->
  conditions = []
  bodies = []
  match 'if'
  conditions.push parseExpression()
  bodies.push parseBody()
  elseifs = []
  while at 'else'
    match 'else'
    if at 'if'
      match()
      conditions.push parseExpression()
      bodies.push parseBody()
    else
      bodies.push parseBody()
      break
  new IfStatement(conditions, bodies)

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