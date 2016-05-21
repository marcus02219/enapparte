angular
  .module 'enapparte'
  .factory 'User_availabilities', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/availabilities',
      name: 'useravailability'
      serializer: railsSerializer ()->
    resource
  ]
  