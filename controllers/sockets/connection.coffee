game = require '../../models/game'

getRandomSign = (socket) ->
  socket.emit 'geetings', game.getRandomSign()

exports = module.exports = (io) ->
  io.sockets.on "connection", getRandomSign