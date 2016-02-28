engine = require './engine'
module.exports = (http)->
  io = require('socket.io')(http)
  console.log "Socket.io initialized"

  io.on 'connection', (socket)->
    console.log "Socket connected", socket.id
    gameId = ''

    socket.on 'game:new', (callback)->
      {gameId,game} = engine.create()
      callback gameId, game
