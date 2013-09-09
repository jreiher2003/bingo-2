Field = require './field'
config = require './../config'
_ = require 'underscore'


class Player

  constructor: (@id) ->
    @field = new Field(config.game.field.nbColumns, config.game.field.nbRows)

  getId: ->
    @id

  getField: ->
    @field

  pickElement: (signId, roundNumber) ->
    if @getField().elementExist(signId)
      @getField().getElement(signId).setPickedInRound(roundNumber).setIsPicked(true)

  getHistory: ->
    _.filter(@getField().getElements(), (element) ->
      element.getIsPicked() is true


module.exports = Player
