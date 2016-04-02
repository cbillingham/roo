class BooleanLiteral
    constructor: (@name) ->

    value: ->
        @name

    toString: ->
        @name

    analyze: (context) ->
        #todo

    optimize: -> 
        this

module.exports = BooleanLiteral