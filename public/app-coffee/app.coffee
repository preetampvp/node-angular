angular.module 'linkedInApp', ['ui.router']
.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  # default route
  $urlRouterProvider.otherwise 'home'

  stateProvider = $stateProvider
  stateProvider
  .state 'home', {
    url: '/home'
    views: {
      main: {
        templateUrl: 'partials/home.html',
        controller: 'Home',
        controllerAs: 'vm'
      },
      header: {
        templateUrl: 'partials/header.html'
      },
      footer: {
        templateUrl: 'partials/footer.html'
      }
    }
  }
]