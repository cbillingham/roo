class FunctionCall

  constructor: (@function, @args) ->

  toString: ->
    "(Call #{@function} (#{@args.join(', ')}))"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = FunctionCall