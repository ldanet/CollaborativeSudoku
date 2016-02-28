shortid = require 'shortid'
_ = require 'lodash'

games = {}

generateNewGame = ->
  game = []
  for [0..8]
    row = []
    for [0..8]
      row.push 0
    game.push row
  game

module.exports = engine =
  create: ->
    id = shortid.generate()
    game = generateNewGame()
    games[id] = game
    gameId: id
    game: game
