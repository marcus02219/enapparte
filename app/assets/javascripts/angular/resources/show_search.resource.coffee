angular
  .module 'enapparte'
  .factory 'ShowSearch', ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer)->
    class ShowSearch extends RailsResource
      @configure
        url: '/api/v1/shows/search',
        name: 'show'
        # serializer: railsSerializer ()->
        #   this.nestedAttribute('pictures')
  ]
