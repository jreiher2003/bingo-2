newGame = (game) ->
  (socket) ->
    game.addPlayer(socket.id)
    socket.emit 'newGame', game.shuffleElements()

    socket.on "pickSign", (data)->
      game.playerPickSign(socket.id, data.sign)
      socket.emit 'pickedSigns', game.getSignsPicketByPlayer(socket.id)

    socket.on "bingo", (data) ->
      game.bingo(socket.id)

exports = module.exports = (io, game) ->
  io.sockets.on "connection", (socket) -> newGame(game)(socket)