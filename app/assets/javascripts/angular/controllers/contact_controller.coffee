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
    uibModalInstance = @uibModalInstance
    flash = @Flash
    user = @rootScope.currentUser
    if user
      data = {email: user.email, message: @scope.contact.message}
    else
      data = {email: @scope.contact.email, message: @scope.contact.message}
    @http(
      method: 'POST'
      url: '/contact'
      data: {contact:@scope.contact}).then ((response) ->
      console.log response
      uibModalInstance.close(true)
      flash.showSuccess @scope, 'Contact mail has been sent successfully.'
      return
    ), (response) ->
      console.log 'test'
      return
