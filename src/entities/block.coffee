class Block
  
  #A block is a list of statements
  constructor: (@statements) ->

  toString: ->
    "(Block #{@statements.join(' ')})"

  analyze: ->
    #TODO

  optimize: ->
    #TODO

module.exports = Block