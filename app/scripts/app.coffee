define [
  'marionette'
  'views/home'
  'socket'
], (
  Marionette
  HomeView
  socket
)->

  class App extends Marionette.Application
    regions:
      mainRegion: '#container'

    initialize: ->
      console.log "Initializing app."
      view = new HomeView

      view.on 'game:start', ->
        #do something

      @mainRegion.show view
