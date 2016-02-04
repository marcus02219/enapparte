angular
  .module 'enapparte'
  .factory 'Picture', ['railsResourceFactory', (railsResourceFactory)->
    railsResourceFactory
      url: '/api/v1/pictures',
      name: 'picture'
  ]
