angular.module("factories").factory "socket", [
  "$rootScope"
  ($rootScope) ->
    socket = io.connect("192.168.40.10:8907");
    (
      on: (eventName, callback) ->
        socket.on eventName, ->
          args = arguments;
          $rootScope.$apply -> callback.apply socket, args

      emit: (eventName, data, callback) ->
        socket.emit eventName, data, ->
          args = arguments;
          $rootScope.$apply -> callback.apply(socket, args) if callback
    )
]