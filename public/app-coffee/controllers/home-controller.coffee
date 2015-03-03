'use strict'

Home = ($scope, linkedInApiService, apiService) ->

  init = () ->
    IN.Event.on(IN, 'auth', vm.auth)

  onAuth = () ->
    if IN.User?
      $scope.$apply vm.isAuthenticated = true
      vm.startFetchingProcess()
    else
      $scope.$apply vm.isAuthenticated = false


  startFetchingProcess = () ->
    vm.updateProgress '- Fetching your Linkedin profile information.'
    myProfilePromise = linkedInApiService.getMyProfile()
    myProfilePromise.then (data) ->
      if data.values?
        vm.linkedInInfo.myProfile = data.values[0]
#        console.log JSON.stringify vm.linkedInInfo.myProfile

        vm.updateProgress "- Hi #{vm.linkedInInfo.myProfile.firstName} #{vm.linkedInInfo.myProfile.lastName}, welcome to PP."
        vm.updateProgress '- Fetching connections'
        myConnectionsPromise = linkedInApiService.getMyConnections()
        myConnectionsPromise.then (data) ->
          if data.values?
            vm.linkedInInfo.myConnections = data.values
#            console.log(JSON.stringify(vm.linkedInInfo.myConnections[0]))
            vm.updateProgress "- Total Connection: #{vm.linkedInInfo.myConnections.length}"
            vm.updateProgress "- Saving LinkedIn profile and connection."
            savePromise = apiService.saveProfileData(vm.linkedInInfo)

            savePromise
            .then () ->
              vm.updateProgress '- Data saved. Thanks you.'
            .catch () ->
              vm.errorSaving = true
              vm.updateProgress '- Error saving data. Please try again later.'

  updateProgress = (text) ->
    vm.processSteps.push text

  vm = this
  vm.isAuthenticated = false
  vm.processSteps = []
  vm.linkedInInfo = {
    myProfile: null,
    myConnections: null
  }

  vm.auth = onAuth
  vm.startFetchingProcess = startFetchingProcess
  vm.updateProgress = updateProgress
  vm.init = init
  vm.errorSaving = false

  return

angular.module 'linkedInApp'
.controller('Home', ['$scope', 'linkedInApiService', 'apiService', Home])