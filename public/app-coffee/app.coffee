angular.module 'linkedInApp', ['ui.router']
.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  # default route
  $urlRouterProvider.otherwise 'home'

  stateProvider = $stateProvider
  stateProvider
  .state 'home', {
    url: '/home',
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

  .state 'stats', {
    url: '/stats',
    views: {
      main: {
        templateUrl: 'partials/stats.html',
        controller: 'Stats',
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

  .state 'loginradius', {
    url: '/loginradius',
    views: {
      main: {
        templateUrl: 'partials/login-radius.html',
        controller: 'LoginRadius',
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

  .state 'loggedon', {
    url: '/loggedon',
    views: {
      main: {
        templateUrl: 'partials/post-logon.html',
        controller: 'PostLogon',
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