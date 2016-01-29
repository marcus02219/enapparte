angular
  .module 'enapparte', ['ngResource', 'ngRoute']

  .config ($routeProvider)->
    $routeProvider
      .when '/show/new',
        templateUrl: 'show/new.html'
        controller: 'ShowController'
      .otherwise
        templateUrl: 'root.html'
        controller: 'RootController'

  .run ($rootScope)->
    $rootScope.flashMessages = true

    $rootScope.$on '$routeChangeStart', (scope, next, current)->
      $rootScope.flashMessages = true
