express = require 'express'
config = require './config'

app = express()
app.set('title', 'Hackaton Bingo')
app.use(express.bodyParser());


app.listen config.app.port
console.log 'Listening on port '+config.app.port