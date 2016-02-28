#/*global require*/
'use strict'

require.config
  shim: {
    bootstrap:
      deps: ['jquery'],
      exports: 'jquery'
  }
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    marionette: '../bower_components/backbone.marionette/lib/core/backbone.marionette'
    'backbone.babysitter': '../bower_components/backbone.babysitter/lib/backbone.babysitter'
    'backbone.wreqr': '../bower_components/backbone.wreqr/lib/backbone.wreqr'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/bootstrap-sass-official/assets/javascripts/bootstrap'
    socketio: '../bower_components/socket.io/lib/socket'
    handlebars: '../bower_components/handlebars/handlebars'


define [
  'app'
], (
  App
) ->

  app = new App
  app.start()
