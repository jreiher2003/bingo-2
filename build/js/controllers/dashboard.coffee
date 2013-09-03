angular.module("controllers").controller "Dashboard", [
  "$scope"
  "socket"
  "$timeout"
  ($scope, socket, $timeout) ->
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
      $timeout(
        ->
          if $scope.nextRevelation > 0
            --$scope.nextRevelation
            lowerRevelation()
        1000
      )

    socket.on "newRound", (whichOne) ->
      $scope.nextRevelationElement = whichOne
      $scope.nextRevelation = 6
      if currentLowerRevelation isnt null
        $timeout.cancel currentLowerRevelation
        console.log currentLowerRevelation
      currentLowerRevelation = lowerRevelation()

    $scope.bingo = ->
      socket.emit "bingo"

    $scope.chooseElement = (element) ->
      element.clicked = true
      socket.emit "pickSign", {sign: element.index}, -> console.log "pickSign"
]