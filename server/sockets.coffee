
module.exports = (http)->
  io = require('socket.io')(http)
  console.log "Socket.io initialized"

  io.on 'connection', (socket)->
    console.log "Socket connected", socket.id
