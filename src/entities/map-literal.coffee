_ = require 'underscore'

class MapLiteral

  constructor: (@keys=[], @values=[]) ->

  toString: ->
    '{' + _.zip(@keys, @values).map((val) ->
      "#{val[0]}: #{val[1]}"
    ).join(', ') + '}'

  analyze: (context) ->
    for key in @keys
      key.analyze context
    for value in @values
      value.analyze context

  optimize: ->
    @keys = (key.optimize() for key in @keys)
    @values = (value.optimize() for value in @values)
    this

module.exports = MapLiteral