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

