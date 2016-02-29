define [
  'lodash'
],(
  _
)->
  checkSetGroup = (group)->
    isValid = true
    for set in group
      unless checkSet(set)
        isValid = false
    isValid

  checkSet = (set)->
    set = _.reject set, (value)-> value is 0
    if _.isEqual _.uniq(set), set
      true
    else false

  createEmptyGroup = ->
    group = []
    for [0..8]
      group.push []
    group

  checkRows = (game)->
    checkSetGroup game

  checkColumns = (game)->
    columns = createEmptyGroup()
    for row, i in game
      for cell, j in row
        columns[j][i] = cell
    checkSetGroup columns

  checkSquares = (game)->
    squares = createEmptyGroup()
    for row, i in game
      y = Math.floor(i / 3)
      for cell, j in row
        x = Math.floor(j/3)
        squares[x+3*y].push cell
    checkSetGroup squares

  check: (game)->
    unless checkRows(game) and checkColumns(game) and checkSquares(game)
      return false
    true
