define [
  'backbone'
], (
  Backbone
)->
  console.log "Called Router"
  class AppRouter extends Backbone.Router
    routes:
      '': 'home'
      ':game': 'game'
