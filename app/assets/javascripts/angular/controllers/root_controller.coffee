angular
  .module 'enapparte'
  .controller 'RootController',
    class RootController
      constructor: ($rootScope, @$scope)->
        $rootScope.flashMessages = false

