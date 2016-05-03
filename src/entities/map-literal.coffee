_ = require 'underscore'

class MapLiteral

  constructor: (@keys=[], @values=[]) ->

  toString: ->
    '{' + _.zip(@keys, @values).map((val) ->
      "#{val[0]}: #{val[1]}"
    ).join(', ') + '}'

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = MapLiteral