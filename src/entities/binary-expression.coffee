class BinaryExpression

  constructor: (@op, @left, @right) ->

  toString: ->
    "(#{@op} #{@left} #{@right})"

  analyze: (context) ->
    #TO DO

  optimize: ->
    #TO DO

module.exports = BinaryExpression