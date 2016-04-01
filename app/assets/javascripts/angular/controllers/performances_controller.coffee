class PerformancesController extends @NGController
  @register window.App, 'PerformancesController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'Booking'
    '$state'
  ]

  tabsPerformances: [
    { heading: 'Current', route: 'dashboard.performances.current' }
    { heading: 'History', route: 'dashboard.performances.history' }
    { heading: 'Cancelled', route: 'dashboard.performances.cancelled' }
  ]

  bookings: []

  init: ->
    @Booking
      .query()
      .then (bookings)=>
        @scope.bookings = bookings

  filterCurrentBookings: (elem)->
    (elem.status == 1 || elem.status == 2) && moment(elem.date) >= moment()

  filterOldBookings: (elem)->
    (elem.status == 1 || elem.status == 2) && moment(elem.date) < moment()

  filterCancelBookings: (elem)->
    (elem.status == 3 || elem.status == 4)

