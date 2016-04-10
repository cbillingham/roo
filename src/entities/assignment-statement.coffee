class AssignmentStatement
  
  constructor: (@variableReference, @value, @global = false) ->

  toString: ->
    "(Assign #{if @global then 'global ' else ''}#{@variableReference} = #{@value})"
  
  isGlobal: ->
    @global

  analyze: ->
    #TODO

  optimize: ->
    #TODO

module.exports = AssignmentStatement