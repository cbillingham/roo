# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require './scanner'
error = require './error'

Program             = require './entities/program'
Block               = require './entities/block'
AssignmentStatement = require './entities/assignment-statement'
ArgumentList        = require './entities/argument-list'
WhileLoop           = require './entities/while-loop'
IfStatement         = require './entities/if-statement'
ReturnStatement     = require './entities/return-statement'
BreakStatement      = require './entities/break-statement'
ContinueStatement   = require './entities/continue-statement'
ForLoop             = require './entities/for-loop'
VariableReference   = require './entities/variable-reference'
FunctionDeclaration = require './entities/function-declaration'
ClassDeclaration    = require './entities/class-declaration'
BinaryExpression    = require './entities/binary-expression'
PreUnaryExpression  = require './entities/pre-unary-expression'
PostUnaryExpression = require './entities/post-unary-expression'
Range               = require './entities/range'
FunctionCall        = require './entities/function-call'
ObjectFieldAccess   = require './entities/object-field-access'
CollectionAccess    = require './entities/collection-access'
BooleanLiteral      = require './entities/boolean-literal'
FloatLiteral        = require './entities/float-literal'
IntegerLiteral      = require './entities/integer-literal'
StringLiteral       = require './entities/string-literal'
NullLiteral         = require './entities/null-literal'
MapLiteral          = require './entities/map-literal'
SetLiteral          = require './entities/set-literal'
ListLiteral         = require './entities/list-literal'
TupleLiteral        = require './entities/tuple-literal'
ListComprehension   = require './entities/list-comprehension'
Lambda              = require './entities/lambda'
ObjectInstance      = require './entities/object-instance'

errors = []
tokens = []
startTokenTypes = ["fun","global","if","for","while","break","continue","return",
                   "loop","class","insist","nulllit","boollit","intlit","!","-","{","(",
                   "floatlit","stringlit","new","<","[","id"]

startExpTypes = ["nulllit","boollit","intlit","!","-","{","(","floatlit","stringlit",
                 "new","<","id"]
assignOps = ['=','%=','*=','/=','+=','-=','++','--']

module.exports = (scannerOutput) ->
  tokens = scannerOutput
  program = parseProgram()
  match 'EOF'
  program

parseProgram = ->
  new Program(parseBlock())

parseBlock = (body = false) ->
  statements = []
  loop
    while at 'EOL'
      match 'EOL'
    if (at 'EOF') or (body and at '}')
      break
    statements.push parseStatement()
    if (body and at '}')
      break
    match 'EOL'
    while at 'EOL'
      match 'EOL'
    break unless at startTokenTypes
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
  else if at 'global'
    parseAssignmentStatement()
  else if at 'id'
    if isAssignment()
      parseAssignmentStatement()
    else
      parseExpression()
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
  identifier = parseVariable()
  if at ['++','--']
    return new PostUnaryExpression(match().lexeme, identifier)
  if at ['%=','*=','/=','+=','-=']
    op = match().lexeme[0]
    right = parseExpression()
    value = new BinaryExpression(op, identifier, right)
  else
    match '='
    value = parseExpression()
  new AssignmentStatement(identifier, value, global)

parseVariable = ->
  id = new VariableReference(match 'id')
  while at ['.','[']
    if at '.'
      match()
      right = new VariableReference(match 'id')
      id = new ObjectFieldAccess(id, right)
    if at '['
      match()
      right = parseExpression()
      match ']'
      id = new CollectionAccess(id, right)
  id

isAssignment = ->
  pos = 1
  brackets = 0
  while (tokens[pos].kind in ['.','['])
    if tokens[pos].kind is '['
      loop
        if at 'EOL'
          return false
        brackets++ if tokens[pos].kind is '['
        brackets-- if tokens[pos].kind is ']'
        pos++
        break if brackets is 0
    else if tokens[pos].kind is '.'
      pos++
      if tokens[pos].kind isnt 'id'
        return false
      pos++
  return (tokens[pos].kind in assignOps)

  
parseWhileLoop = ->
  if at 'loop'
    match()
    condition = new BooleanLiteral(true)
  else if at 'while'
    match()
    condition = parseExpression()
  body = parseBody()
  new WhileLoop(condition, body)

parseBody = ->
  match '{'
  body = parseBlock(body = true)
  match '}'
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
  if at 'id'
    ids = [new VariableReference(match 'id')]
    if at ','
      match()
      ids.push new VariableReference(match 'id')
    match 'in'
  source = parseExpression()
  body = parseBody()
  new ForLoop(source, body, ids)

parseFunDec = ->
  match 'fun'
  identifier = new VariableReference(match 'id')
  params = parseParams()
  body = parseBody()
  new FunctionDeclaration(identifier, params, body)

parseParams = ->
  params = []
  match '('
  while not at ')'
    id = new VariableReference(match 'id')
    if at '='
      match()
      exp = parseExpression()
      id = new AssignmentStatement(id, exp)
    params.push id
    match ',' if not at ')'
  match ')'
  params

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
  if (at ['<','>','<=','>=','==','!=','is','isnt']) and (nextIs startExpTypes)
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
    if at 'by'
      match()
      step = parseExp4()
    return new Range(left, right, step)
  else
    left = parseExp4()
    if at '..'
      match
      if at 'by'
        match()
        step = parseExp4()
      left = new Range(left, right, step)
    else if at 'to'
      match()
      right = parseExp4()
      if at 'by'
        match()
        step = parseExp4()
      left = new Range(left, right, step)
    left
      

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
    return parseObjectCreation()
  left = parseExp9()
  while at ['.','[','(']
    if at '.'
      match()
      right = new VariableReference(match 'id')
      left = new ObjectFieldAccess(left, right)
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
    value = match().lexeme is "true"
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
    if isLambda()
      return parseLambdaExp()
    match '('
    if at ')'
      match()
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
    exp = parseExpression()
    exps.push exp
    match ',' if not at end

parseExpList = (exps = [], end = ')') ->
  while not at end
    exps.push parseExpression()
    if at ',' then match ',' else break
  exps

parseLambdaExp = ->
  params = parseParams()
  match '->'
  block = parseBody()
  new Lambda(params, block)

parseObjectCreation = ->
  match 'new'
  classId = new VariableReference(match 'id')
  match '('
  args = parseExpList()
  match ')'   
  new ObjectInstance(classId, args)

parseMapLiteral = ->
  keys = []
  values = []
  match '{'
  while not at '}'
    keys.push(match('id').lexeme)
    match ':'
    values.push parseExpression()
    match ',' if not at '}'
  match '}'
  new MapLiteral(keys, values)

parseListLiteral = ->
  match '['
  if at ']'
    match()
    return new ListLiteral()
  else
    exp = parseExpression()
    if at 'for'
      parseListComprehension(exp)
    else
      match ',' if at ','
      exps = parseExpList([exp],']')
      match ']'
      new ListLiteral(exps)

parseSetLiteral = ->
  match '<'
  exps = parseExpList([],'>')
  match '>'
  new SetLiteral(exps)

parseListComprehension = (exp) ->
  match 'for'
  id = new VariableReference(match 'id')
  match 'in'
  source = parseExpression()
  match ']'
  new ListComprehension(exp, id, source)

at = (kind) ->
  if tokens.length is 0
    false
  else if Array.isArray kind
    kind.some(at)
  else
    kind is tokens[0].kind

nextIs = (kind) ->
  if tokens.length < 2
    false
  else if Array.isArray kind
    kind.some(nextIs)
  else
    kind is tokens[1].kind

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
    parens++ if token.kind is '('
    parens-- if token.kind is ')'
    pos++
    break if parens is 0
  if tokens[pos]?
    tokens[pos].kind is '->'
  else
    false
