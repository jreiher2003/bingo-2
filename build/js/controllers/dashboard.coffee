angular.module("controllers").controller "Dashboard", [
  "$scope"
  "socket"
  "$window"
  ($scope, socket, $window) ->
    $scope.nextRevelation = 5
    $scope.nextRevelationElement = false

    $scope.elements = []
    for i in [0..24]
      $scope.elements.push (
        clicked: false
        value: false
        index: i
      )

    socket.on "newGame", (board) ->
      i = -1;
      for value in board
        $scope.elements[++i].value = value

    currentLowerRevelation = null
    lowerRevelation = ->
      $scope.$apply ->
        if $scope.nextRevelation > 0
          --$scope.nextRevelation


    socket.on "newRound", (whichOne) ->
      $scope.nextRevelationElement = whichOne
      $scope.nextRevelation = 5

      if currentLowerRevelation isnt null
        $window.clearInterval currentLowerRevelation

      currentLowerRevelation = $window.setInterval lowerRevelation, 1000
    $scope.bingo = ->
      socket.emit "bingo", {}, -> console.log "clicked bingo"

    $scope.chooseElement = (element) ->
      element.clicked = true
      socket.emit "pickSign", {sign: element.index}, -> console.log "pickSign"
]