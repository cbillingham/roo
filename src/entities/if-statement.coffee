class IfStatement
    constructor: (@condition, @body, @elseifStatements, @else) ->

    toString: ->
        "If #{@condition} #{@body}"

    analyze: ->
        #todo

    optimize: ->
        #todo

module.exports = IfStatement