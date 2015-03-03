LinkedInApiService = ($q) ->
  {
    getMyProfile: () ->
      deferred = $q.defer()

      IN.API
      .Profile('me')
      .fields(['id','first-name', 'last-name', 'email-address', 'positions', 'languages'])
      .result (data) ->
        deferred.resolve(data)

      return deferred.promise
    ,

    getMyConnections: () ->
      deferred = $q.defer()
      IN.API
      .Connections('me')
      .fields(['id','first-name'
      , 'last-name', 'email-address'
      , 'positions', 'languages'
      , 'location', 'headline'
      , 'industry'])
      .result (data) ->
        deferred.resolve data

      return deferred.promise

  }

angular.module 'linkedInApp'
.factory 'linkedInApiService', [ '$q', LinkedInApiService]