game = require '../../models/game'

newGame = (socket) ->
  socket.emit 'newGame', game.getRandomSign()

exports = module.exports = (io) ->
  io.sockets.on "connection", newGame