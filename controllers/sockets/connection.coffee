newGame = (game) ->
  (socket) ->
    userElements = game.shuffleElements()
    game.addPlayer(socket.id, userElements)
    socket.emit 'newGame', userElements

    socket.on "pickSign", (data)->
      game.playerPickSign(socket.id, data.sign)
      socket.emit 'pickedSigns', game.getSignsPicketByPlayer(socket.id)

    socket.on "bingo", (data) ->
      isWinner =  game.bingo(socket.id)

      if isWinner
        socket.emit 'gameOver'
        socket.disconnect()

exports = module.exports = (io, game) ->
  io.sockets.on "connection", (socket) -> newGame(game)(socket)