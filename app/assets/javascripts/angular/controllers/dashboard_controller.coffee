class DashboardController extends @NGController
  @register window.App, 'DashboardController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$state'
    'Show'
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
    @Show
      .query()
      .then (shows)=>
        if shows.length > 0
          tab = { heading: 'My Performances', route: 'dashboard.performances.current', routeActive: 'dashboard.performances' }
          @scope.tabs.splice 4, 0, tab

