angular
  .module 'enapparte'
  .factory 'Show', ['railsResourceFactory', 'railsSerializer', 'Picture', (railsResourceFactory, railsSerializer, Picture)->
    resource = railsResourceFactory
      url: '/api/v1/shows',
      name: 'show'
      serializer: railsSerializer ()->
        this.nestedAttribute('pictures')

    resource.prototype.activate = ()->
      resource
        .$post '/api/v1/shows/' + this.id + '/activate'

    resource
  ]
