class WhileLoop

  constructor: (@condition, @body) ->

  toString: ->
    "(While #{@condition} #{@body})"

  analyze: (context) ->
    #TO DO

  optimize: ->
    #TO DO

module.exports = WhileLoop