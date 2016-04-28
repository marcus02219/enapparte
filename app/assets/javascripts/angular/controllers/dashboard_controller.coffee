class DashboardController extends @NGController
  @register window.App, 'DashboardController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$state'
    'Show'
    'Auth'
    'Flash'
  ]

  tabs: [
    { heading: 'Dashboard', route: 'dashboard.index' }
    { heading: 'Profile', route: 'dashboard.profile.personal', routeActive: 'dashboard.profile' }
    { heading: 'Messages', route: 'dashboard.messages' }
    { heading: 'My Shows', route: 'dashboard.shows' }
    { heading: 'My Reservations', route: 'dashboard.reservations.current', routeActive: 'dashboard.reservations' }
    { heading: 'Account', route: 'dashboard.account.payment', routeActive: 'dashboard.account' }
  ]

  init: ->
    unless @Auth.isAuthenticated()
      @state.go 'home'
      @Flash.showError @scope, "You need to sign in or sign up before continuing."
      return
    @Show
      .query()
      .then (shows)=>
        if shows.length > 0
          tab = { heading: 'My Performances', route: 'dashboard.performances.current', routeActive: 'dashboard.performances' }
          if @scope.tabs[4].heading != tab.heading
            @scope.tabs.splice 4, 0, tab

