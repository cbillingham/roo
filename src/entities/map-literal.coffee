_ = require 'underscore'

class MapLiteral

  constructor: (@keys, @values) ->

  toString: ->
    '{' + _.zip(@keys, @values).map((val) ->
      "#{val[0]}: #{val[1]}"
    ).join(', ') + '}'

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = MapLiteral