angular
  .module 'enapparte'
  .factory 'User', ['railsResourceFactory', 'railsSerializer', (railsResourceFactory, railsSerializer)->
    resource = railsResourceFactory
      url: '/api/v1/users',
      name: 'user'
      serializer: railsSerializer ()->
        this.nestedAttribute('picture')
        this.resource('picture', 'Picture')
        this.nestedAttribute('addresses')
        this.resource('addresses', 'Address')

    resource
  ]
