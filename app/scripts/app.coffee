define [
  'backbone'
  'marionette'
  'socket'
  'router'
  'views/home'
  'views/game'
], (
  Backbone
  Marionette
  SocketManager
  Router
  HomeView
  GameView
)->

  class App extends Marionette.Application
    regions:
      mainRegion: '#container'

    initialize: ->
      console.log "Initializing app."
      @socket = new SocketManager
      @router = new Router

    showHomeView: =>
      @view = new HomeView

      @view.on 'game:start', =>
        @socket.emit 'game:new', (gameId,game)=>
          console.log "Got new game!", gameId,game
          @router.navigate gameId
          @showGameView(gameId, game)

      @mainRegion.show @view

    showGameView: (gameId,game)=>
      @view = new GameView
        gameId: gameId
        game: game
        socket: @socket

      @view.on 'game:error': =>
        @showHomeView()

      @mainRegion.show @view

    onStart: ->
      @router.on 'route:home', @showHomeView
      @router.on 'route:game', @showGameView
      Backbone.history.start()
