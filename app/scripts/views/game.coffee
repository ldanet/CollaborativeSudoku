define [
  'lodash'
  'backbone'
  'marionette'
  'templates'
  'utils/gameChecker'
  'views/game/row'
], (
  _
  Backbone
  Marionette
  templates
  gameChecker
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
      @model = new Backbone.Model
      @model.on 'change', @checkIsValid
      @socket.on 'value:change', @handleServerChange
      unless game?
        @socket.emit 'game:get', @gameId, (game)=>
          if game is false
            @trigger 'game:error'
          else
            @model.set 'game', game
            @collection = new Backbone.Collection game
            @render()
      else
        @model.set 'game', game
        @collection = new Backbone.Collection game

    handleChange: (view,change)=>
      game = @model.get 'game'
      @updateGameModel change
      @socket.emit 'value:change', @gameId, change

    handleServerChange: (gameId, change)=>
      if gameId is @gameId
        rowView = @children.findByIndex change.rowIndex
        @updateGameModel change
        rowView.updateCell change

    updateGameModel: (change)=>
      game = _.clone @model.get('game')
      game[change.rowIndex][change.cellIndex] = change.value
      game =  game
      @model.set 'game', game
      @model.trigger 'change'

    checkIsValid: =>
      game = @model.get 'game'
      isValid = gameChecker.check game
      if isValid
        @$el.removeClass 'invalid'
      else
        @$el.addClass 'invalid'
