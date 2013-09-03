module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    coffee:
      build:
        options:
          join: true
        files:
          "public/js/application.js": [
            "build/js/factories/socketio.coffee"
            "build/js/application.coffee"
          ]

  grunt.loadNpmTasks "grunt-contrib-coffee"
