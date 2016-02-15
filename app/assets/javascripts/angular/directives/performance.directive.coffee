angular
  .module 'enapparte'
  .directive 'performance', ['Flash', (Flash)->
    {
      strict: 'E'
      templateUrl: 'performance/list.html'
      scope: {
        booking: '='
      }
      replace: true
      link: (scope, element, attrs, ctrl)->
        # accept
        scope.acceptBooking = (booking, index)->
          booking
            .changeStatus(1)
            .then (result)->
              booking.status = 1
              Flash.showNotice('You\'ve accepted the request successfully.')

        # cancel
        scope.cancelBooking = (booking, index)->
          booking
            .changeStatus(3)
            .then (result)->
              booking.status = 3
              Flash.showNotice('You\'ve cancelled the booking request.')
    }
  ]
