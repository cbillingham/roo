class AssignmentStatement
  
  constructor: (@variableReference, @value, global) ->
    @global = global ? ""

  toString: ->
     "(Assignment Statement #{@global} #{@variableReference.toString()} = #{@value})"
  
  isGlobal: ->
    @global?

  analyze: ->
     #TODO

  optimize: ->
     #TODO

module.exports = AssignmentStatement