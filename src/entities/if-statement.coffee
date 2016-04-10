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

  analyze: ->
      #todo

  optimize: ->
      #todo

module.exports = IfStatement