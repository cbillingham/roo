class FunctionDeclaration

  constructor: (@name, @params, @body) ->

  toString: ->
    "(Function #{@name} (#{@params.join(', ')}) #{@body})"

  analyze: (context) ->
    @body.analyze context.createChildContext({inFunction:true})

  optimize: ->
    @body = @body.optimize()
    this

module.exports = FunctionDeclaration