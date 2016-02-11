angular
  .module 'enapparte'
  .factory 'Picture', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/api/v1/pictures',
      name: 'picture'

    resource
  ]
