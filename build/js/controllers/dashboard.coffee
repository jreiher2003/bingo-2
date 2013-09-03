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
        clicked: ""
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

      if lastPicked isnt null and typeof lastPicked isnt "undefined"
        e = lastPicked.filter (el) -> el isnt null
        for el in $scope.elements
          for i in e
            el.clicked = ""
            if parseInt(el.index, 10) is parseInt(i, 10)
              el.clicked = "successed"

    lastPicked = null
    socket.on "pickedSigns", (picked) ->
      lastPicked = picked

    $scope.bingo = ->
      socket.emit "bingo", {}, ->

    $scope.chooseElement = (element) ->
      if element.clicked.length < 1
        element.clicked = "clicked"
        socket.emit "pickSign", {sign: element.index}, ->
]