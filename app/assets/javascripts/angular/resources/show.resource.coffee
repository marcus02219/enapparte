angular
  .module 'enapparte'
  .factory 'Show', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    railsResourceFactory
      url: '/api/v1/shows',
      name: 'show'
      serializer: railsSerializer ()->
        this.exclude('pictures')
        # this.nestedAttribute('pictures')
  ]
