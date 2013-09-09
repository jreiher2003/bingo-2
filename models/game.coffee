db = require '../db'
uuid = require 'node-uuid'
config = require './../config'
_ = require 'underscore'
Field = require './field'
FieldElement = require './fieldElement'
Player = require './player'


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

  getPlayer: (playerId) ->
    @players[playerId]

  addPlayer: (player) ->
    @players[player.getId()] = player

  getRandomElement: ->
    @elements[Math.floor(Math.random()*@elements.length - 1) + 1]

  fireLoop: ->
    setInterval @createNewRound, config.game.roundTime

  createNewRound: =>
    @element = @getRandomElement()
    @roundNumber = @roundNumber + 1

    @io.sockets.emit 'newRound', @element
    @io.sockets.emit 'roundNumber', @roundNumber

  createPlayer: (playerId, elements) ->
    @addPlayer new Player playerId, elements

  playerPickSign: (playerId, signId) ->
    if @element is signId
      @getPlayer(playerId).pickElement signId, @roundNumber

  bingo: (playerId) ->
    console.log 'elements: '+@getPlayerElements(playerId)
    console.log 'picks: '+@getSignsPicketByPlayer(playerId)

