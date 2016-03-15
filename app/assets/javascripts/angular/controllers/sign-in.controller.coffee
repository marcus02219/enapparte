class SignInController extends @NGController
  @register window.App, 'SignInController'

  @$inject: [
    '$scope'
    '$uibModalInstance'
    'Auth'
    'Flash'
    '$rootScope'
  ]

  auth:
    email: ''
    password: ''

  ok: ()=>
    @Auth
      .login @scope.auth, {'X-HTTP-Method-Override': 'POST'}
      .then (user)=>
        if @Auth.isAuthenticated()
          @rootScope.currentUser = user
          @uibModalInstance.close(@scope.auth)
          @Flash.showSuccess @scope, 'Signed in successfully.'

      , (e)=>
        @Flash.showError @scope, e.data.error

  cancel: ()=>
    @uibModalInstance.dismiss('cancel')
