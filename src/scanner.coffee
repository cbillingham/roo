fs        = require 'fs'
byline    = require 'byline'
{XRegExp} = require 'xregexp'
error     = require './error'

LETTER = XRegExp '[\\p{L}]'
DIGIT = XRegExp '[\\p{Nd}]'
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'
KEYWORDS = /^(global|if|else|for|while|break|continue|loop|true|false|to|by|is|isnt|in|and|or|class|null|new|insist)$/

module.exports = (filename, callback) ->
  baseStream = fs.createReadStream filename, {encoding: 'utf8'}
  baseStream.on 'error', (err) -> error(err)

  stream = byline baseStream, {keepEmptyLines: true}
  tokens = []
  linenumber = 0
  stream.on 'readable', () ->
    scan stream.read(), ++linenumber, tokens
  stream.once 'end', () ->
    tokens.push {kind: 'EOF', lexeme: 'EOF'}
    callback tokens

scan = (line, linenumber, tokens) ->