db = require '../db'
uuid = require 'node-uuid'

module.exports =
  createGame: ->
    new Game()


class Game

  constructor: ->
    @id = uuid.v4()
    @elements = [1..30]


  shuffleElements: ->
    res = []
    for i in [0..24]
      res.push @elements[Math.floor(Math.random()*@elements.length - 1) + 1]

    res
