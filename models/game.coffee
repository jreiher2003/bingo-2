db = require '../db'
uuid = require 'node-uuid'
config = require './../config'


module.exports =
  createGame: (io)->
    new Game(io)


class Game

  constructor: (@io) ->
    @id = uuid.v4()
    @elements = config.game.elements
    @element = @getRandomElement()
    @fireLoop()
    @players = []
    @roundNumber = 0


  shuffleElements: ->
    res = []
    for i in [0..24]
      res.push @getRandomElement()

    res

  getRandomElement: ->
    @elements[Math.floor(Math.random()*@elements.length - 1) + 1]

  fireLoop: ->
    setInterval @createNewRound, config.game.roundTime

  createNewRound: =>
    @roundNumber = @roundNumber + 1
    @io.sockets.emit 'newRound', @getRandomElement()
    @io.sockets.emit 'roundNumber', @roundNumber

  getSignsPicketByPlayer: (playerId) ->
    @players[playerId]

  addPlayer: (playerId) ->
    @players[playerId] = []

  playerPickSign: (playerId, signId) ->
    @players[playerId][@roundNumber] = signId

  bingo: (playerId) ->
    'dupa'

