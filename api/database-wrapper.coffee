mongojs = require 'mongojs'
Q = require 'q'
_ = require 'lodash'

connectionString = '127.0.0.1:27017/LinkedInProfiles'
if process.env.MongoConnection?
  connectionString = "#{process.env.MongoConnection}/LinkedInProfiles"

profileCollection = 'profiles'

db = mongojs connectionString

checkIfProfileExists = (id) ->
  deferred = Q.defer()
  query = {
    "myProfile.id" : id
  }

  db.collection(profileCollection).find(query, { _id : 1}, (err, docs) ->
    if err?
      deferred.reject()
      return

    if docs? and docs.length is 0 then deferred.resolve false else deferred.resolve true
  )

  return deferred.promise

saveProfile = (profile) ->
  deferred = Q.defer()
  db.collection(profileCollection).insert(profile, (err) ->

    if err?
      deferred.reject()
      return

    deferred.resolve()
  )

  return deferred.promise

getStats = () ->
  deferred = Q.defer()

  db.collection(profileCollection).find({}, {
    'myProfile.firstName' : 1,
    'myProfile.lastName' : 1,
    'myProfile.emailAddress': 1,
    'myConnections': 1,
    '_id': 0 }, (err, docs) ->

    if err?
      console.log err
      deferred.reject()
      return

    data = []
    _.each docs, (doc) ->
      name = "#{doc.myProfile.firstName} #{doc.myProfile.lastName}"

      emailAddress = ''
      if doc.myProfile.emailAddress?
        emailAddress = doc.myProfile.emailAddress

      totalConnections = 0
      connectionsNotHidden = 0
      if doc.myConnections?
        totalConnections = doc.myConnections.length
        notHiddenConnections =  _.filter doc.myConnections, (connection) ->
          connection.id isnt 'private'

        connectionsNotHidden = notHiddenConnections.length

      data.push {
        name: name,
        emailAddress: emailAddress,
        totalConnections: totalConnections,
        connectionsNotHidden: connectionsNotHidden
      }

    deferred.resolve data
  )

  return deferred.promise

DatabaseWrapper = {
  checkIfProfileExists: checkIfProfileExists,
  saveProfile: saveProfile
  getStats: getStats
}

module.exports = DatabaseWrapper
