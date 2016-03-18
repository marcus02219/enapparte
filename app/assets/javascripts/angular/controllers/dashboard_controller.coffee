class DashboardController extends @NGController
  @register window.App, 'DashboardController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$state'
  ]

  tabs:[
    { heading: 'Dashboard', route: 'dashboard', active: true }
    { heading: 'Profile', route: 'dashboard.profile', active: false }
    { heading: 'Messages', route: 'dashboard.messages', active: false }
  ]

  go: (route)=>
    @state.go route

  init: ->

