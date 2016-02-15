angular
  .module 'enapparte'
  .controller 'PerformancesController', ['$scope', 'Booking', ($scope, Booking)->

    $scope.bookings = []

    $scope.init = ()->
      Booking
        .query()
        .then (bookings)->
          $scope.bookings = bookings

    $scope.filterCurrentBookings = (elem)->
      (elem.status == 1 || elem.status == 2) && moment(elem.date) >= moment()

    $scope.filterOldBookings = (elem)->
      (elem.status == 1 || elem.status == 2) && moment(elem.date) < moment()

    $scope.filterCancelBookings = (elem)->
      (elem.status == 3 || elem.status == 4)
  ]
