angular
  .module 'enapparte'
  .factory 'ShowArt', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/shows/arts',
      name: 'art'
      # serializer: railsSerializer ()->
      #   this.nestedAttribute('pictures')

    resource
  ]
