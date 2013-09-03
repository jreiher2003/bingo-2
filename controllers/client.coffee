game = require '../models/game'

getRoot = (req, res) ->
  response =
    number: game.getRandomSign()

  res.render "client.ejs", response

exports = module.exports = (app) ->
  app.get "/client", getRoot