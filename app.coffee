express = require 'express'
config = require './config'
io = require 'socket.io'


app = express()
app.set 'title', 'Hackaton Bingo'
app.set 'views', "#{__dirname}/views"

app.use express.static "#{__dirname}/public"
app.use    express.bodyParser()
app.use("/js", express.static(__dirname + '/public/js'));
app.engine 'ejs', (require 'ejs').renderFile

(require './controllers/dashboard') app
(require './controllers/client') app

io.listen(app.listen(config.app.port));
console.log "Listening on port #{config.app.port}"
