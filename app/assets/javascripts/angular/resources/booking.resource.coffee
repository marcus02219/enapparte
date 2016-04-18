angular
  .module 'enapparte'
  .factory 'Booking', ['railsResourceFactory', 'railsSerializer', 'Picture', (railsResourceFactory, railsSerializer, Picture)->
    resource = railsResourceFactory
      url: '/api/v1/bookings',
      name: 'booking'
      interceptors: ['saveIndicatorInterceptor']
      # serializer: railsSerializer ()->
      #   this.nestedAttribute('pictures')

    resource.prototype.changeStatus = (status)->
      resource
        .$post '/api/v1/bookings/' + this.id + '/change_status', { status: status }

    resource
  ]
