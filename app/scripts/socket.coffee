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

      @socket.on 'value:change',(args...)=>
        @trigger 'value:change', args...


    emit: (args...)->
      @socket.emit args...
