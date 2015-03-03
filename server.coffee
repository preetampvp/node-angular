'use strict'
express = require 'express'
bodyParser = require 'body-parser'
path = require 'path'
app = express()

app.use(bodyParser.urlencoded({ extended: false }))
app.use bodyParser.json()

publicFolder = './public/'
app.use(express.static(path.join(__dirname, 'public')))


app.get '/', (req, rep) ->
  rep.sendFile "#{publicFolder}index.html"

app.post '/api/saveProfile', (req, res) ->
  console.log req.body.msg
  # do save data here
  res.sendStatus 200

app.listen process.env.port || "9000", () ->
  console.log 'server started.'
