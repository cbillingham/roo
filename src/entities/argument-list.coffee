class ArgumentList

  constructor: (@expressions) ->

  toString: ->
    "(#{@expressions.join(', ')})"

  analyze: (context) ->
    #TO DO

  optimize: ->
    #TO DO

module.exports = ArgumentList