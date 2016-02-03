angular
  .module 'enapparte'
  .factory 'Show', ['$resource', ($resource)->
    $resource('/api/v1/shows/:id', {id:'@id'})
  ]
