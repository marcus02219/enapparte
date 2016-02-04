angular
  .module 'enapparte', ['rails', 'ngRoute']

  # .config ($routeProvider)->
  #   $routeProvider
  #     .when '/show/new',
  #       templateUrl: 'show/new.html'
  #       controller: 'ShowController'
  #     .otherwise
  #       templateUrl: 'root.html'
  #       controller: 'RootController'

  .config ["$httpProvider", ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ]

  .run ['$rootScope', ($rootScope)->
    $rootScope.flashMessages = true

    $rootScope.$on '$routeChangeStart', (scope, next, current)->
      $rootScope.flashMessages = true
  ]
