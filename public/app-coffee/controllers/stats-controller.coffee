StatsController = (apiService) ->

  init = () ->
    promise = apiService.getStats()
    promise
    .then (data) ->
      vm.stats = data
    .catch () ->
      vm.err = true

  vm = this
  vm.init = init
  vm.stats = []
  vm.err = false

  return

angular.module 'linkedInApp'
.controller 'Stats', ['apiService', StatsController]
