_ = require 'underscore'

class IfStatement
  constructor: (@conditions, @bodies) ->

  toString: ->
    s = "If #{@conditions[0]} #{@bodies[0]}"
    for [condition, body] in _.zip(@conditions[1..], @bodies[1..])
      if condition?
        s = s.concat " else if #{condition} #{body}"
      else
        s = s.concat " else #{body}"
    s = "(#{s})"

  analyze: (context) ->
    for condition in @conditions
      condition.analyze context
    for body in @bodies
      body.analyze context        #same scope for if blocks

  optimize: ->
    @conditions = (condition.optimize() for condition in @conditions)
    @bodies = (body.optmize() for body in @bodies)
    this

module.exports = IfStatement