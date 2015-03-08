loginradius = require './login-radius.js'
Q = require 'q'

secretKey = '85c8cfe4-16d7-47c4-a74c-38d69cebb998'


getUserProfile = (token) ->
  deferred = Q.defer()

  loginradius.getAccessToken token, secretKey, (lToken) ->
    unless lToken.access_token?
      deferred.reject()
      return

    accessToken = lToken.access_token
    loginradius.getUserprofile accessToken, (data) ->
      deferred.resolve data

  return deferred.promise


LoginRadiusWrapper = {
  getUserProfile: getUserProfile

}

module.exports = LoginRadiusWrapper