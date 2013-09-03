angular.module("controllers").controller "Dashboard", [
  "$scope"
  "socket"
  ($scope, socket) ->
    $scope.elements = []
    for i in [0..24]
      $scope.elements.push (
        clicked: false
        value: false
      )

    socket.on "newGame", (board) ->
      i = -1;
      for value in board
        $scope.elements[++i].value = value

    $scope.bingo = ->

    $scope.chooseElement = (element) ->
      console.log element
]