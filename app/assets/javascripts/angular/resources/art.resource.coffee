angular
  .module 'enapparte'
  .factory 'Art', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/arts',
      name: 'art'
      # serializer: railsSerializer ()->
      #   this.nestedAttribute('pictures')

    resource
  ]
