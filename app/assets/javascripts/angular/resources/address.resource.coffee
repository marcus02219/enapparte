angular
  .module 'enapparte'
  .factory 'Address', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/address',
      name: 'address'
      serializer: railsSerializer ()->

    resource
  ]
