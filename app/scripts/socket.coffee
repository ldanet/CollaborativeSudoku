require [
  'socketio'
], (
  socketio
)->

  socket = socketio()
  console.log "Created socket", socket
  socket.on 'connection',->
    console.log "Socket connected!"
