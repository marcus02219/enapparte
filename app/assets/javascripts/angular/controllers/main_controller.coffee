angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', '$uibModal', 'Auth', '$state', ($rootScope, $scope, $sanitize, $uibModal, Auth, $state)->

    $rootScope.Math = window.Math

    $scope.broadcast = (event)->
      $scope.$broadcast event

    $rootScope.range = (n)->
      new Array(n)

    $rootScope.isAuthenticated = ()->
      Auth.isAuthenticated()
    $rootScope.isPerformer = ()->
      Auth._currentUser.role in ["admin", "performer"]
    $rootScope.logout = ()->
      Auth.logout().then ()->
        $rootScope.currentUser = null
        $state.go 'home'
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

