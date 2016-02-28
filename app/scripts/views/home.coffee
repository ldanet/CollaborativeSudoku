define [
  'backbone'
  'marionette'
  'templates'
], (
  Backbone
  Marionette
  templates
)->
  class HomeView extends Marionette.ItemView
    className: 'home'
    template: templates.home.hbs

    initialize: ->
      @model = new Backbone.Model
      @model.set 'test', 'Chapachas'
