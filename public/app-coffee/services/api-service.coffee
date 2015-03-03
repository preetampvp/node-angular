apiBaseUrl = "http://localhost:9000/api/"

ApiService = ($q, $http) ->
  {
    saveProfileData: (profileData) ->
      deferred = $q.defer()
      $http.post "#{apiBaseUrl}saveProfile", {
        msg: profileData
      }
      .success (data, status) ->
        console.log data, status
        deferred.resolve()
      .error (data, status) ->
        console.log data, status
        deferred.reject()

      return deferred.promise

  }

angular.module 'linkedInApp'
.factory 'apiService', [ '$q', '$http', ApiService]