class DashboardAccountController extends @NGController
  @register window.App, 'DashboardAccountController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'User'
    '$state'
  ]

  tabsAccount: [
    { heading: 'Payment', route: 'dashboard.account.payment' }
    { heading: 'Information', route: 'dashboard.account.information' }
    { heading: 'Security', route: 'dashboard.account.security' }
  ]

  user: {}

  init: ->
    @User
      .get(1)
      .then (user)=>
        @scope.user = user

  changePassword: =>
    @userSave 'Password was changed successfully.'

  changeEmail: =>
    @userSave 'Email was changed successfully.'

  userSave: (notice)=>
    if @scope.user
      @scope.user.save()
        .then (user)=>
          @scope.user = user
          @Flash.showNotice @scope, notice
        , (error)->
          # @Flash.showError @scope, 'User was saved successfully.'

