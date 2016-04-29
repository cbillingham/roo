util = require('util')
Context = require('../entities/Context')

module.exports = (program) ->
  gen program

indentPadding = 4
indentLevel = 0
globalContext = new Context()
currentContext = globalContext
lastId = 0

getNewId = () ->
  lastId += 1

emit = (line) ->
  pad = indentPadding * indentLevel
  console.log(Array(pad+1).join(' ') + line)

makeOp = (op) ->
  {not: '!', and: '&&', or: '||', '==': '===', '!=': '!=='}[op] or op

gen = (e) ->
  console.log(e)
  generator[e.constructor.name](e)
  
generator =

  Program: (program) ->
    indentLevel = 0
    emit '(() => {'
    gen program.block
    emit '}());'

  Block: (block) ->
    indentLevel++
    currentContext = new Context(currentContext)
    gen statement for statement in block.statements
    indentLevel--
    currentContext = currentContext.parent

  AssignmentStatement: (s) ->
    emit "#{gen s.target} = #{gen s.source};"

  WhileStatement: (s) ->
    emit "while (#{gen s.condition}) {"
    gen s.body
    emit '}'

  PrintStatement: (p) ->
    emit "console.log(#{gen p.expression});"

  BreakStatement: (b) ->
    emit "break;"

  ContinueStatement: (c) ->
    emit "continue;"

  IfStatement: (i) ->
    emit "#{i.toString()}"

  Lambda: (l) ->
    emit "(#{gen l.params}) => {
      #{gen l.body}
    }"

  ClassDeclaration: (c) ->
    emit "class #{currentContext.makeVariable(c.name)} {"
      #TODO
    emit "}"

  CollectionAccess: (c) ->
    #TODO

  InsistStatement: (i) ->
    emit "if (!(#{gen i.condition}){
        throw \"argument failed condition: #{i.condition.toString()})\"
      }"

  ArgumentList: (a) ->
    #TODO

  ForLoop: (f) ->
    #TODO

  FunctionCall: (f) ->
    #TODO 

  ListComprehension: (l) ->
    #TODO

  ObjectFieldAccess: (o, f) ->
    emit "#{o.source}.#{f}"

  ObjectInstance: (o) ->
    #TODO

  PostUnaryExpression: (p) ->
    emit p.toString()

  PreUnaryExpression: (p) ->
    emit p.toString()

  Range: (r) ->
    start = "#{r.left}"
    end = "#{r.right}"
    step = "#{r.step}"

    range = []
    range.push(x for x in [start..end] by step)

    emit range.toString()

  VariableReference: (v) ->
    #TODO

  WhileLoop: (w) ->
    emit "while (#{gen w.condition}){#{gen w.body}}"

  ReturnStatement: (r) ->
    emit "return #{gen r.expression};"

  FunctionDeclaration: (f) ->
    emit "var #{makeVariable f.name} (#{gen f.params}) => { }"

  IntegerLiteral: (literal) -> literal.toString()

  BooleanLiteral: (literal) -> literal.toString()

  NullLiteral: (literal) -> literal.toString()

  TupleLiteral: (literal) -> 
    emit "[literal.elements[0], literal.elements[1]]"

  MapLiteral: (literal) -> literal.toString()

  ListLiteral: (literal) -> literal.toString()

  FloatLiteral: (literal) -> literal.toString()

  SetLiteral: (literal) ->
    emit "new Set(#{literal.elements})"

  VariableReference: (v) -> 
    if(v.global) 
      globalContext.makeVariable(v.referent, getNewId())
    else
      currentContext.makeVariable(v.referent, getNewId())

  UnaryExpression: (e) -> "(#{makeOp e.op.lexeme} #{gen e.operand})"

  BinaryExpression: (e) ->
    "(#{gen e.left} #{makeOp e.op.lexeme} #{gen e.right})"
