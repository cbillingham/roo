class Lambda

  constructor: (@params, @body) ->

  toString: ->
    "((#{@params.join(', ')}) -> #{@body})"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = Lambda