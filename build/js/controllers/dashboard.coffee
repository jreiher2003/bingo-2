angular.module("controllers").controller "Dashboard", [
  "$scope"
  "socket"
  ($scope, socket) ->
    $scope.elements = []
    elements = []
    for i in [0..24]
      $scope.elements.push (
        clicked: false
        value: false
      )

    console.log elements

    socket.on "new-game", ->
      console.log arguments
]