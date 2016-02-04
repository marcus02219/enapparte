angular
  .module 'enapparte'
  .controller 'profile', ['$scope', '$resource', ($scope, $resource)->
    User = $resource('/api/v1/users/:action/:id.json')

    $scope.user = User.get({ id: 1 })
  ]


