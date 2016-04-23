class ReturnStatement
  
  constructor: (@expression) ->

  toString: ->
    "(Return #{@expression})"

  analyze: (context) ->
    #TODO

  optimize: ->
    #TODO

module.exports = ReturnStatement