express = require 'express'
config = require './config'
game = require('./models/game')

app = express()
app.set 'title', 'Hackaton Bingo'
app.set 'views', "#{__dirname}/views"

app.use express.static "#{__dirname}/public"
app.use express.bodyParser()

app.engine 'ejs', (require 'ejs').renderFile

(require './controllers/dashboard') app

io = require('socket.io').listen(app.listen(config.app.port));

gameInstance = game.createGame(io)

(require './controllers/sockets/connection') io, gameInstance
(require './controllers/sockets/game') io


console.log "Listening on port #{config.app.port}"
