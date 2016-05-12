class ClassDeclaration

  constructor: (@name, @body) ->

  toString: ->
    "(Class #{@name} #{@body})"

  analyze: (context) ->
    @name.analyze context
    @body.analyze context.createChildContext()

  optimize: ->
    @name = @name.optimize()
    @body = @body.optimize()
    this

module.exports = ClassDeclaration