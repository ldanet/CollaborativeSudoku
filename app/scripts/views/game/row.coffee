define [
  'backbone'
  'marionette'
  'templates'
  'views/game/cell'
], (
  Backbone
  Marionette
  templates
  CellView
)->
  class RowView extends Marionette.CollectionView
    tagName: 'tr'
    childView: CellView

    childViewOptions: (model,index)->
      cellIndex: index

    childEvents:
      'value:change': 'handleValueChange'

    initialize: ->
      console.log "rowIndex", @options.rowIndex
      cells = @model.get 'cells'
      for value, index in cells
        cells[index] =
          value: value
      @collection = new Backbone.Collection cells

    onRender: ->
      @$el.addClass @options.rowIndex

    handleValueChange: (view,value)=>
      @trigger 'value:change',
        cellIndex: view.options.cellIndex
        rowIndex: @options.rowIndex
        value: value
