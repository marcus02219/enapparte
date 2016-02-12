angular
  .module 'enapparte'
  .factory 'Booking', ['railsResourceFactory', 'railsSerializer', 'Picture', (railsResourceFactory, railsSerializer, Picture)->
    resource = railsResourceFactory
      url: '/api/v1/bookings',
      name: 'booking'
      # serializer: railsSerializer ()->
      #   this.nestedAttribute('pictures')

    resource
  ]
