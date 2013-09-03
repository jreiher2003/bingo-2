game = require '../../models/game'

getRandomSign = (socket) ->
  socket.emit 'greetings', game.getRandomSign()

exports = module.exports = (io) ->
  io.sockets.on "connection", getRandomSign