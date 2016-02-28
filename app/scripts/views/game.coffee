define [
  'lodash'
  'backbone'
  'marionette'
  'templates'
  'views/game/row'
], (
  _
  Backbone
  Marionette
  templates
  RowView
)->

  class GameView extends Marionette.CompositeView
    className: 'game'
    template: templates.game.hbs
    childView: RowView

    childViewContainer: 'tbody'

    childViewOptions: (model, index)->
      model.set 'cells', _.values(model.toJSON())
      rowIndex: index

    initialize: ->
      console.log "Initializing Game View", @options
      {gameId,game,@socket} = @options
      if game is undefined
        @socket.emit 'game:get', gameId, (game)->
          @collection = new Backbone.Collection game

      @collection = new Backbone.Collection game
