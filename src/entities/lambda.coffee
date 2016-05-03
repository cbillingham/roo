class Lambda

  constructor: (@params, @body) ->

  toString: ->
    "((#{@params.join(', ')}) -> #{@body})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = Lambda