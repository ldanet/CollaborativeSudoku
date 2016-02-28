define [
  'marionette'
  'socketio'
], (
  Marionette
  socketio
)->

  class SocketManager extends Marionette.Controller
    initialize: ->
      @socket = socketio()

      @socket.on 'connection',->
        console.log "Socket connected!"


    emit: (args...)->
      @socket.emit args...
