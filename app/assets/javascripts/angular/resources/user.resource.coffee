angular
  .module 'enapparte'
  .factory 'User', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/users',
      name: 'user'
      serializer: railsSerializer ()->
        this.nestedAttribute('picture')
        this.resource('picture', 'Picture')

        this.nestedAttribute('addresses')
        this.resource('addresses', 'Address')

        this.nestedAttribute('reviews')
        this.resource('reviews', 'Review')

        this.nestedAttribute('paymentMethods')
        this.resource('payment_methods', 'PaymentMethod')

        this.nestedAttribute('bookings')
        this.resource('bookings', 'Booking')

    resource
  ]
