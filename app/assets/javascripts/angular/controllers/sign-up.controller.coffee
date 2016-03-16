class SignUpController extends @NGController
  @register window.App, 'SignUpController'

  @$inject: [
    '$scope'
    '$uibModalInstance'
    'Auth'
    'Flash'
    '$rootScope'
  ]

  user:
    email: ''
    password: ''

  ok: ()=>
    @Auth
      .register @scope.user, {}
      .then (user)=>
        if @Auth.isAuthenticated()
          @rootScope.currentUser = user
          @uibModalInstance.close(@scope.auth)
          @Flash.showSuccess @scope, 'Signed up successfully.'
      , (e)=>
        if e.data.error
          @Flash.showError @scope, e.data.error
        if e.data.errors
          angular.forEach e.data.errors, (v, k)=>
            @Flash.showError @scope, k.charAt(0).toUpperCase() + k.slice(1) + ': ' + v


  cancel: ()=>
    @uibModalInstance.dismiss('cancel')
