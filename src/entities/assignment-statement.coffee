class AssignmentStatement
  
  constructor: (@variableReference, @value, global, constant) ->
    @global = global ? ""
    @constant = constant ? ""

  toString: ->
     "(Assign #{@global} #{@variableReference} = #{@value})"
  
  isGlobal: ->
    @global?

  analyze: ->
     #TODO

  optimize: ->
     #TODO

module.exports = AssignmentStatement