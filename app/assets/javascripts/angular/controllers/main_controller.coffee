angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', '$uibModal', 'Auth', ($rootScope, $scope, $sanitize, $uibModal, Auth)->

    $rootScope.Math = window.Math

    $scope.broadcast = (event)->
      $scope.$broadcast event

    $rootScope.range = (n)->
      new Array(n)

    $rootScope.isAuthenticated = ()->
      Auth.isAuthenticated()

    $rootScope.logout = ()->
      Auth.logout().then ()->
        $rootScope.currentUser = null

    $rootScope.showSignIn = ()->
      $uibModal.open
        animation: true
        templateUrl: 'devise/log_in.html'
        controller: 'SignInController'

    $rootScope.showSignUp = ()->
      $uibModal.open
        animation: true
        templateUrl: 'devise/sign_up.html'
        controller: 'SignUpController'
  ]

