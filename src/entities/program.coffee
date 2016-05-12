initialContext = require('../analyzer').initialContext

class Program

  constructor: (@block) ->

  toString: ->
    "(Program #{@block})"

  analyze: (context) ->
    @block.analyze initialContext()

  optimize: ->
    @block = @block.optimize()
    return this

module.exports = Program