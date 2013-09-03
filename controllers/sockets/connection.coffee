game = require '../../models/game'

newGame = (game) ->
  (socket) ->
    socket.emit 'newGame', game.shuffleElements()

exports = module.exports = (io, game) ->
  io.sockets.on "connection", (socket) -> newGame(game)(socket)