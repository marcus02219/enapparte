class ContactController extends @NGController
  @register window.App, 'ContactController'

  @$inject: [
    '$scope'
    '$uibModalInstance'
    'Auth'
    'Flash'
    '$rootScope'
    '$http'
  ]

  ok: ()=>
    console.log(@scope.contact)
    $http(
      method: 'POST'
      url: '/contact'
      data: @scope.contact).then ((response) ->
      console.log response
      @Flash.showSuccess @scope, 'Contact mail is sent successfully.'
      return
    ), (response) ->
      console.log 'test'
      return
