class FunctionDeclaration

  constructor: (@name, @params, @body) ->

  toString: ->
    "(Function #{@name} (#{@params.join(', ')}) #{@body})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = FunctionDeclaration