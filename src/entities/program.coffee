#initialContext = require('../analyzer/analyzer').initialContext

class Program
  constructor: (@block) ->

  toString: ->
    "(Program #{@block})"

  analyze: ->
    #TODO

  optimize: ->
    #TODO

module.exports = Program