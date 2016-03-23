class DashboardController extends @NGController
  @register window.App, 'DashboardController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$state'
  ]

  tabs: [
    { heading: 'Profile', route: 'dashboard.profile', active: true }
    { heading: 'Dashboard', route: 'dashboard', active: false }
    { heading: 'Messages', route: 'dashboard.messages', active: false }
  ]

  go: (route)=>
    @state.go route

  init: ->

