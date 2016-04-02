class NullLiteral
    constructor: ->
        @value = null

    value: ->
        @value

    toString: ->
        @value

    analyze: ->
        #todo

    optimize: ->
        this

module.exports = NullLiteral