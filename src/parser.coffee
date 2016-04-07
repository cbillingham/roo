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
    while at 'EOL'
      match 'EOL'
    if at 'EOF'
      break
    statements.push parseStatement()
    match 'EOL'
    while at 'EOL'
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
  else if at ['global','const','id']
    parseAssignmentStatement()
  else if at 'fun'
    parseFunDec()
  else if at 'class'
    parseClassDec()
  else
    parseExpression()

parseAssignmentStatement = ->
  if at 'global'
    match()
    global = true
  # if at 'const'
  #   match()
  #   constant = true
  #   if at 'global'        #fix this to be more elegant
  #     match()
  #     global = true
  identifier = new VariableReference(match 'id')
  if at ['++','--']
    return new PostUnaryExpression(identifier, match().lexeme)
  if at ['%=','*=','/=','+=','-=']
    op = match().lexeme[0]
    right = parseExpression()
    value = new BinaryExpression(op, identifier, right)
  else
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
  body = parseBlock()
  match '}'
  match 'EOL'
  body

parseReturnStatement = ->
  match 'return'
  new ReturnStatement parseExpression()

parseBreakStatement = ->
  match 'break'
  new BreakStatement()

parseContinueStatement = ->
  match 'continue'
  new ContinueStatement()

parseIfStatement = ->
  conditions = []
  bodies = []
  match 'if'
  conditions.push parseExpression()
  bodies.push parseBody()
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

parseForLoop = ->
  match 'for'
  iteration = parseExpression()
  body = parseBody()
  new ForLoop(iteration, body)

parseFunDec = ->
  match 'fun'
  identifier = new VariableReference(match 'id')
  params = parseParams()
  body = parseBody()
  new FunctionDeclaration(identifier, param, body)

parseParams = ->
  match '('
  match 'id'

parseClassDec = ->
  match 'class'
  identifier = new VariableReference(match 'id')
  body = parseBody()
  new ClassDeclaration(identifier, body)

parseExpression = ->
  left = parseExp1()
  while at ['or','||']
    op = match().lexeme
    right = parseExp1()
    left = new BinaryExpression(op, left, right)
  left

parseExp1 = ->
  left = parseExp2()
  while at ['and','&&']
    op = match().lexeme
    right parseExp2()
    left = new BinaryExpression(op, left, right)
  left

parseExp2 = ->
  left = parseExp3()
  if at ['<','>','<=','>=','==','!=','is','isnt']
    op = match().lexeme
    right = parseExp3()
    left = new BinaryExpression(op, left, right)
  left

parseExp3 = ->
  left = null
  right = null
  if at '..'
    match()
    right = parseExp4()
  else
    left = parseExp4()
    if at '..'
      match
    else if at 'to'
      match()
      right = parseExp4()
  if at 'by'
    match()
    step = parseExp4()
  new Range(left, right, step)

parseExp4 = ->
  left = parseExp5()
  while at ['+','-']
    op = match().lexeme
    right = parseExp5()
    left = new BinaryExpression(op, left, right)
  left

parseExp5 = ->
  left = parseExp6()
  while at ['*','/','%','//']
    op = match().lexeme
    right = parseExp6()
    left = new BinaryExpression(op, left, right)
  left

parseExp6 = ->
  if at ['!','-']
    op = match().lexeme
    right = parseExp7()
    left = new PreUnaryExpression(op, right)
  else
    parseExp7()

parseExp7 = ->
  left = parseExp8()
  if at ['**']
    op = match().lexeme
    right = parseExp8()
    left = new BinaryExpression(op, left, right)
  left

parseExp8 = ->
  if at 'new'
    parseObjectCreation()
  left = parseExp9()
  while at ['.','[','(']
    if at '.'
      match()
      right = parseExp9()
      left = new FieldAccess(left, right)
    if at '['
      match()
      right = parseExpression()
      match ']'
      left = new CollectionAccess(left, right)
    if at '('
      match '('
      args = parseExpList()
      match ')'
      left = new FunctionCall(left, args)
  left

parseExp9 = ->
  if at 'boollit'
    value = Boolean(match().lexeme)
    new BooleanLiteral(value)
  else if at 'intlit'
    value = Number(match().lexeme)
    new IntegerLiteral(value)
  else if at 'floatlit'
    value = Number(match().lexeme)
    new FloatLiteral(value)
  else if at 'stringlit'
    new StringLiteral(match().lexeme)
  else if at 'nulllit'
    match()
    new NullLiteral()
  else if at 'id'
    identifier = new VariableReference(match 'id')
  else if at '['
    parseListLiteral()
  else if at '<'
    parseSetLiteral()
  else if at '{'
    parseMapLiteral()
  else if at '('
    if isLambda
      return parseLambdaExp()
    match '('
    if at ')'
      return new TupleLiteral()
    else
      exp = parseExpression()
      if at ','
        match()
        exp = new TupleLiteral( parseExpList([exp]) )
      match ')'
    exp
  else
    error 'Illegal start of expression', tokens[0]

parseExpList = (exps = [], end = ')') ->
  while not at end
    exps.push parseExpression()
    match ',' if not at end
  exps

parseObjectCreation = ->
  match 'new'
  classId = new VariableReference(match 'id')
  match '('
  args = parseExpList()
  match ')'
  new Object(classId, args)

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

isLambda = ->
  parens = 0
  pos = 0
  for token in tokens
    parens++ if tokens.kind is '('
    parens-- if tokens.kind is ')'
    pos++
    break if parens is 0
  tokens[pos].kind is '->'
