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
      for i in [0..24]
        $scope.elements[i].value = board[i]

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
          el.clicked = ""
          for i in e
            if parseInt(el.value, 10) is parseInt(i, 10)
              el.clicked = "successed"

      isBingo()

    isBingo = ->
      for e in [0, 5, 10, 15, 20]
        _isBingo = []
        for i in [e..e+5]
          _isBingo.push if $scope.elements[i].clicked is "successed" then 1 else 0

        sum = 0
        for elToSum in _isBingo
          sum += elToSum

        if elToSum > 4
          console.log "BINGO!"


    lastPicked = null
    socket.on "pickedSigns", (picked) ->
      lastPicked = picked

    $scope.bingo = ->
      socket.emit "bingo", {}, ->

    $scope.chooseElement = (element) ->
      if element.clicked.length < 1
        element.clicked = "clicked"
        socket.emit "pickSign", {sign: element.value}, ->
]