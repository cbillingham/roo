error = require './error'

module.exports = (targetType) ->
  console.log __dirname
  try
    console.log "generators/#{targetType}-generator"
    generator = require "generators/#{targetType}-generator"
  catch e
    error "No such target type: #{targetType}"
  generator
