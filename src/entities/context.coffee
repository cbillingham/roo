HashMap = require('hashmap').HashMap

class Context 
    constructor: (@parent) ->
        @children = []
        @parent.children.push(this)
        @variables = new HashMap()
        @lastId = 0

    makeVariable:(v, lastId) -> 
        variables.set v, ++lastId if not variables.has v
        '_v' + variables.get v

    getNewVariableName

module.exports = Context