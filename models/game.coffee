db = require '../db'
uuid = require 'node-uuid'
config = require './../config'


module.exports =
  createGame: (io)->
    new Game(io)


class Game

  constructor: (@io) ->
    @id = uuid.v4()
    @elements = [1..30]
    @element = @getRandomElement()
    @fireLoop()


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
    @element = @getRandomElement()
    @io.sockets.emit 'newRound', @element
