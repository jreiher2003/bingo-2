config = require './../config'
_ = require 'underscore'
FieldElement = require './fieldElement'


class Field

  constructor: (@nbColumn, @nbRows) ->
    @elements = []
    @generateElements()

  getElements: ->
    @elements

  getElementsList: ->
    tmpArray = []

    for element in @elements
      tmpArray.push(element.getSign())

    tmpArray


  addElement: (element) ->
    @elements= element

  generateElements: ->
    tmpElements = _.shuffle(config.game.elements)

    i = 0
    for column in [0..@nbColumn-1]
      for row in [0..@nbRows-1]
        @elements.push new FieldElement(tmpElements[i], column, row)
        i++

  elementExist: (signId)->
    if @getElement(signId)
      return true
    return false

  getElement: (signId) ->
    _.find @getElements(), (fieldElement) ->
      fieldElement.getSign() is signId

module.exports = Field