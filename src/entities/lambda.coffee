class Lambda

  constructor: (@params, @body) ->

  toString: ->
    "((#{@params.join(', ')}) -> #{@body})"

  analyze: (context) ->
    @body.analyze context.createChildContext({inFunction:true})

  optimize: ->
    @body = @body.optimize()
    this

module.exports = Lambda