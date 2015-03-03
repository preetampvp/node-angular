'use strict'
express = require 'express'
bodyParser = require 'body-parser'
path = require 'path'
app = express()

databaseWrapper = require './api/database-wrapper.coffee'

app.use(bodyParser.urlencoded({ extended: false }))
app.use bodyParser.json()

publicFolder = './public/'
app.use(express.static(path.join(__dirname, 'public')))

app.get '/', (req, rep) ->
  rep.sendFile "#{publicFolder}index.html"

app.post '/api/saveProfile', (req, res) ->
  profile = req.body.msg
  id = profile.myProfile.id
  promise = databaseWrapper.checkIfProfileExists id
  promise
  .then (doesExist) ->
    if doesExist is true
      res.sendStatus 200
      return

    savePromise = databaseWrapper.saveProfile profile
    savePromise
    .then () ->
      res.sendStatus 200
    .catch () ->
      res.sendStatus 500

  .catch () ->
    res.sendStatus 500


app.listen process.env.port || "9000", () ->
  console.log 'server started.'
