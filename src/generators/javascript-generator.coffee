util = require('util')
HashMap = require('hashmap').HashMap

module.exports = (program) ->
  gen program

indentPadding = 4
indentLevel = 0

emit = (line) ->
  pad = indentPadding * indentLevel
  console.log(Array(pad+1).join(' ') + line)

makeOp = (op) ->
  {not: '!', and: '&&', or: '||', '==': '===', '!=': '!=='}[op] or op

makeVariable = do (lastId = 0, map = new HashMap()) ->
  (v) ->
    map.set v, ++lastId if not map.has v
    '_v' + map.get v

gen = (e) ->
  generator[e.constructor.name](e)

generator =

  Program: (program) ->
    indentLevel = 0
    emit '(() => {'
    gen program.block
    emit '}());'

  Block: (block) ->
    indentLevel++
    gen statement for statement in block.statements
    indentLevel--

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
    emit: "#{i.toString()}"

  Lambda: (l) ->
    emit "(#{gen l.params}) => {
      #{gen l.body}
    }"

  ClassDeclaration: (c) ->
    emit "class #{makeVariable(c.name)} {"
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

  ObjectFieldAccess: (o) ->
    #TODO

  ObjectInstance: (o) ->
    #TODO

  PostUnaryExpression: (p) ->
    #TODO

  PreUnaryExpression: (p) ->
    #TODO

  Range: (r) ->
    #TODO

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
    #TODO

  MapLiteral: (literal) -> literal.toString()

  ListLiteral: (literal) -> literal.toString()

  FloatLiteral: (literal) -> literal.toString()

  SetLiteral: (literal) ->
    #TODO

  VariableReference: (v) -> makeVariable v.referent

  UnaryExpression: (e) -> "(#{makeOp e.op.lexeme} #{gen e.operand})"

  BinaryExpression: (e) ->
    "(#{gen e.left} #{makeOp e.op.lexeme} #{gen e.right})"
