error = require './../error'

class BreakStatement

  constructor: ->

  toString: ->
    "(Break)"

  analyze: (context) ->
    if not context.inLoop
      error "Break Statement outside loop"

  optimize: ->
    this

module.exports = BreakStatement