express = require 'express'
app = express()

app.get '/', (req, rep) ->
  rep.send 'Hello World'

app.listen process.env.port || "8081", () ->
  console.log 'server started.'
