LinkedInApiService = ($q) ->
  {
    getMyProfile: () ->
      deferred = $q.defer()

      IN.API
      .Profile('me')
      .fields(['id',
               'first-name',
               'last-name',
               'email-address',
               'location',
               'positions'
               ])
      .result (data) ->
        deferred.resolve(data)

      return deferred.promise
    ,

    getMyConnections: () ->
      deferred = $q.defer()
      IN.API
      .Connections('me')
      .fields(['id',
               'first-name',
               'last-name',
               'positions',
               'location' ])
      .result (data) ->
        deferred.resolve data

      return deferred.promise

  }

angular.module 'linkedInApp'
.factory 'linkedInApiService', [ '$q', LinkedInApiService]