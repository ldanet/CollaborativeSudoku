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

    childEvents:
      'change': 'handleChange'

    initialize: ->
      console.log "Initializing Game View", @options
      {@gameId,game,@socket} = @options
      @socket.on 'value:change', @handleServerChange
      unless game?
        @socket.emit 'game:get', @gameId, (game)=>
          console.log "got game from server", game
          if game is false
            @trigger 'game:error'
          else
            @collection = new Backbone.Collection game
            @render()
      else
        @collection = new Backbone.Collection game

    handleChange: (view,change)=>
      console.log "Value changed", change
      @socket.emit 'value:change', @gameId, change

    handleServerChange: (gameId, change)=>
      console.log "Game change from server"
      if gameId is @gameId
        rowView = @children.findByIndex change.rowIndex
        rowView.updateCell change
