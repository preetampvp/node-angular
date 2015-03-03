mongojs = require 'mongojs'
Q = require 'q'

connectionString = process.env.connectionString || '127.0.0.1:27017/LinkedInProfiles'
db = mongojs connectionString

checkIfProfileExists = (id) ->
  deferred = Q.defer()
  query = {
    "myProfile.id" : id
  }

  db.collection('profiles').find(query, { _id : 1}, (err, docs) ->
    if err?
      deferred.reject()
      return

    if docs? and docs.length is 0 then deferred.resolve false else deferred.resolve true
  )

  return deferred.promise

saveProfile = (profile) ->
  deferred = Q.defer()
  db.collection('profiles').insert(profile, (err) ->

    if err?
      deferred.reject()
      return

    deferred.resolve()
  )

  return deferred.promise

DatabaseWrapper = {
  checkIfProfileExists: checkIfProfileExists,
  saveProfile: saveProfile
}

module.exports = DatabaseWrapper
