'use strict'
express = require 'express'
path = require 'path'
app = express()

publicFolder = './public/'

app.use(express.static(path.join(__dirname, 'public')))

app.get '/', (req, rep) ->
  rep.sendFile "#{publicFolder}index.html"

app.listen process.env.port || "9000", () ->
  console.log 'server started.'
