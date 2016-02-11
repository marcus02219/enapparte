angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', 'Flash', ($rootScope, $scope, $sanitize, Flash)->

    $scope.broadcast = (event)->
      $scope.$broadcast event

  ]

