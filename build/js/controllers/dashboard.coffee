angular.module("controllers").controller "Dashboard", [
  "socket"
  (socket) ->
    socket.on "new-game", ->
      console.log arguments
]