class Block
  
  #A block is a list of statements
  constructor: (@statements) ->

  toString: ->
    "(Block #{@statements.join(' ')})"

  analyze: (context) ->
    for statement in @statements
      statement.analyze context

  optimize: ->
    @statements = (s.optimize() for s in @statements)
    @statements = (s for s in @statements when s isnt null)
    this

module.exports = Block