class ReturnStatement
  
  constructor: (@expression) ->

  toString: ->
    "(Return #{@expression})"

  analyze: ->
    #TODO

  optimize: ->
    #TODO

module.exports = ReturnStatement