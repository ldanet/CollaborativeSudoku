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

    triggers:
      'click #startButton':'game:start'
