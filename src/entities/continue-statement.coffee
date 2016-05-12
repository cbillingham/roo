error = require './../error'

class ContinueStatement

  constructor: ->

  toString: ->
    "(Continue)"

  analyze: (context) ->
    if not context.inLoop
      error "Continue Statement outside loop"

  optimize: ->
    this

module.exports = ContinueStatement