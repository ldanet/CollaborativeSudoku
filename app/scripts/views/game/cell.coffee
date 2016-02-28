define [
  'marionette'
  'templates'
], (
  Marionette
  templates
)->

  class CellView extends Marionette.ItemView
    tagName: 'td'
    template: templates.game.cell.hbs

    ui:
      input: 'input'

    events:
      'input @ui.input': 'handleInput'

    initialize: ->
      value = @model.get 'value'
      if value is 0
        @model.set 'value', ''

    handleInput: =>
      value = @ui.input.val()
      value = value[value.length-1]
      value = parseInt value
      displayValue = value
      if value > 9 or value < 1 or isNaN(value)
        value = 0
        displayValue = ''
      @ui.input.val displayValue
      @trigger 'value:change', value
