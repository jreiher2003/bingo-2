Player = require '../../models/player'


newGame = (game) ->
  (socket) ->

    game.addPlayer new Player socket.id
    socket.emit 'newGame', game.getPlayer(socket.id).getField().getElementsList()

    socket.on "pickSign", (data)->
      game.playerPickSign(socket.id, data.sign)
      socket.emit 'pickedSigns', game.getPlayer(socket.id).getHistory()

    socket.on "bingo", (data) ->
      isWinner =  game.bingo(socket.id)

      if isWinner
        socket.emit 'gameOver'
        socket.disconnect()

exports = module.exports = (io, game) ->
  io.sockets.on "connection", (socket) -> newGame(game)(socket)