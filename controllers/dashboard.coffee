getClient = (req, res) ->
  res.render "dashboard.ejs"

exports = module.exports = (app) ->
  app.get "/", getClient