PostLogon = ($location, apiService) ->
  vm = this
  vm.token = $location.search().token
  vm.errorMessage = ''
  vm.profile = null

  promise = apiService.getLoginRadiusInfo vm.token
  promise.then (data) ->
    vm.profile = data
    console.log vm.profile
  .catch () ->
    vm.errorMessage = "error fetching data."

  return


angular.module 'linkedInApp'
.controller 'PostLogon', ['$location' ,'apiService', PostLogon]