angular
  .module 'enapparte'
  .factory 'Show', ['railsResourceFactory', 'railsSerializer', 'Picture', (railsResourceFactory, railsSerializer, Picture)->
    railsResourceFactory
      url: '/api/v1/shows',
      name: 'show'
      serializer: railsSerializer ()->
        this.nestedAttribute('pictures')
  ]
