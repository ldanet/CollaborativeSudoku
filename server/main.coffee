express = require 'express'
http = require 'http'
Sockets = require './sockets'

node_env = process.env.NODE_ENV

app = express()

if node_env is 'livereload'
  app.use require('connect-livereload')({port: 35729})
  app.use express.static('.tmp')
  app.use express.static('app')
else
  app.use express.static('dist')

server = http.createServer(app).listen process.env.PORT, ->
  console.log "Server app listening on port #{process.env.PORT}, environment is #{node_env}"

sockets = Sockets(server) #start socket.io
