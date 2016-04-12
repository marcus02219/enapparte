angular
  .module 'enapparte'
  .factory 'PaymentMethod', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/payment_methods',
      name: 'payment_method'
      serializer: railsSerializer ()->

    resource
  ]
