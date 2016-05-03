class Block
  
  #A block is a list of statements
  constructor: (@statements) ->

  toString: ->
    "(Block #{@statements.join(' ')})"

  analyze: (context) ->
    #TODO

  optimize: ->
    #TODO

module.exports = Block