StatsController = (apiService) ->

  init = () ->
    promise = apiService.getStats()
    promise
    .then (data) ->
      if data.length is 0
        vm.noData = true
      else
        vm.stats = data
    .catch () ->
      vm.err = true

  vm = this
  vm.init = init
  vm.stats = []
  vm.err = false
  vm.noData = false

  return

angular.module 'linkedInApp'
.controller 'Stats', ['apiService', StatsController]
