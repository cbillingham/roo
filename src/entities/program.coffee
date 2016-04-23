class Program

  constructor: (@block) ->

  toString: ->
    "(Program #{@block})"

  analyze: (context) ->
    #TODO

  optimize: ->
    #TODO

module.exports = Program