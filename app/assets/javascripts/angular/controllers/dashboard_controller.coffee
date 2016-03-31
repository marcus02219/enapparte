class DashboardController extends @NGController
  @register window.App, 'DashboardController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$state'
  ]

  tabs: [
    { heading: 'Dashboard', route: 'dashboard.index', active: true }
    { heading: 'Profile', route: 'dashboard.profile.personal', active: false }
    { heading: 'Messages', route: 'dashboard.messages', active: false }
  ]

  go: (route)=>
    @state.go route

  init: ->

