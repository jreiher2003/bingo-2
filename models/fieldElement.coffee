class FieldElement

  constructor: (@sign, @x, @y) ->
    @isPicked = false
    @pickedInRound = null

  getSign: ->
    @sign

  getX: ->
    @x

  getY: ->
    @y

  setIsPicked: (isPicked) ->
    @isPicked = isPicked
    @

  getIsPicked: ->
    @isPicked

  setPickedInRound: (round) ->
    @pickedInRound = round
    @


module.exports = FieldElement
