angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', ($rootScope, $scope, $sanitize)->

    $scope.broadcast = (event)->
      $scope.$broadcast event

    $rootScope.range = (n)->
      new Array(n)

  ]

