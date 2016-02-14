angular
  .module 'enapparte'
  .controller 'PerformancesController', ['$scope', 'Booking', ($scope, Booking)->

    $scope.currentBookings = []
    $scope.oldBookings = []
    $scope.cancelledBookings = []

    $scope.init = ()->
      Booking
        .query( type: 'current' )
        .then (bookings)->
          $scope.currentBookings = bookings
      Booking
        .query( type: 'old' )
        .then (bookings)->
          $scope.oldBookings = bookings
      Booking
        .query( type: 'cancelled' )
        .then (bookings)->
          $scope.cancelledBookings = bookings


  ]
