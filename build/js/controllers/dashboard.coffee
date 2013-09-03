angular.module("controllers").controller "Dashboard", [
  "$scope"
  "socket"
<<<<<<< Updated upstream
  (socket) ->
    socket.on "new-game", ->
      console.log arguments
=======
  ($scope, socket) ->

    $scope.elements = []
    for i in [0..24]
      $scope.elements.push (
        clicked: false
        value: false
      )

    socket.on "new-game", (data) ->
      # init dashboard

    $scope.bingo = ->
>>>>>>> Stashed changes
]