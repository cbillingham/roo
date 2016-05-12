error = require './../error'

class ReturnStatement
  
  constructor: (@expression) ->

  toString: ->
    "(Return #{@expression})"

  analyze: (context) ->
    if not context.inFunction
      error "Return Statement outside function"

  optimize: ->
    this

module.exports = ReturnStatement