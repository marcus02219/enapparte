class ContactController extends @NGController
  @register window.App, 'ContactController'

  @$inject: [
    '$scope'
    '$uibModalInstance'
    'Auth'
    'Flash'
    '$rootScope'
  ]

  ok: ()=>
    console.log(@scope.contact)
