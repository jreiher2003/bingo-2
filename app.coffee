express = require 'express'
config = require './config'


app = express()
app.set 'title', 'Hackaton Bingo'
app.set 'views', "#{__dirname}/views"

app.use express.static "#{__dirname}/public"
app.use express.bodyParser()

app.engine 'ejs', (require 'ejs').renderFile

(require './controllers/dashboard') app
(require './controllers/client') app

io = require('socket.io').listen(app.listen(config.app.port));


(require './controllers/sockets/connection') io
(require './controllers/sockets/game') io


console.log "Listening on port #{config.app.port}"
