angular
  .module 'enapparte'
  .factory 'Picture', ['$resource', ($resource)->
    $resource('/api/v1/pictures/:id', {id:'@id'})
  ]
