angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', '$uibModal', ($rootScope, $scope, $sanitize, $uibModal)->

    $rootScope.Math = window.Math

    $scope.broadcast = (event)->
      $scope.$broadcast event

    $rootScope.range = (n)->
      new Array(n)

    $rootScope.showSignIn = ()->

      modalInstance = $uibModal.open
        animation: true
        templateUrl: 'devise/log_in.html'
        controller: 'MainController'
        resolve:
          items: ()->
            $scope.items

  ]

