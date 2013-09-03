game = require '../../models/game'

pickSign = (socket) ->
  socket

bingo = (socket) ->
  socket

newGame = (socket) ->
  socket

exports = module.exports = (io) ->
  io.sockets.on "newGame", newGame
  io.sockets.on "pickSign", pickSign
  io.sockets.on "bingo", bingo