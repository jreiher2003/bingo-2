db = require '../db'
uuid = require 'node-uuid'
config = require './../config'
_ = require 'underscore'


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
    _.shuffle(@elements)

  getRandomElement: ->
    @elements[Math.floor(Math.random()*@elements.length - 1) + 1]

  fireLoop: ->
    setInterval @createNewRound, config.game.roundTime

  createNewRound: =>
    @roundNumber = @roundNumber + 1
    @element = @getRandomElement()
    @io.sockets.emit 'newRound', @element
    @io.sockets.emit 'roundNumber', @roundNumber

  getSignsPicketByPlayer: (playerId) ->
    @players[playerId]['history']

  addPlayer: (playerId, elements) ->
    @players[playerId] = []
    @players[playerId]['elements'] = elements
    @players[playerId]['history'] = []

  getPlayerElements: (playerId)  ->
    @players[playerId]['elements']

  playerPickSign: (playerId, signId) ->
    index = _.indexOf(@getPlayerElements(playerId), signId)

    if index > -1
      console.log @element is signId, @element , signId
      if @element is signId
        @players[playerId]['history'][@roundNumber] = signId

  bingo: (playerId) ->
    'dupa'

