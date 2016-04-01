angular
  .module 'enapparte'
  .factory 'Review', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/review',
      name: 'review'
      serializer: railsSerializer ()->

    resource
  ]
