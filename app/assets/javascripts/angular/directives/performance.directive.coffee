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
        scope.changeStatus = (booking, status, index)->
          booking
            .changeStatus(status)
            .then (result)->
              booking.status = result.status
              if result.status == 1
                Flash.showNotice('You accepted the request successfully.')
    }
  ]
