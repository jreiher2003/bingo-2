config = require '../config'

module.exports = (app) ->
  app.get '/', dashboard

dashboard = (req, res) ->
  res.send('dashboard')
