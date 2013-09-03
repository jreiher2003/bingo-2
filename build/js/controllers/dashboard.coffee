angular.module("controllers").controller "Dashboard", [
  "socket"
  (socket) ->
    elements = []
    for i in [0..24]
      elements.push Math.floor(Math.random() * 30) + 1

    console.log elements

#    socket.on "new-game", ->
#      console.log arguments
]