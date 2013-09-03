angular.module("controllers").controller "Dashboard", [
  "$scope"
  "socket"
  ($scope, socket) ->
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

    $scope.bingo = ->
      socket.emit "bingo"

    $scope.chooseElement = (element) ->
      element.clicked = true
      socket.emit "pickSign", {sign: element.index}
]