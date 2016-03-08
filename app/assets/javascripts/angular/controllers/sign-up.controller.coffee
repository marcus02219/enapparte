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
      , (e)=>
        @Flash.showError @scope, e.data.error

  cancel: ()=>
    @uibModalInstance.dismiss('cancel')
