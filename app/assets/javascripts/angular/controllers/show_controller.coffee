angular
  .module 'enapparte'
  .controller 'ShowController', ['$scope', ($scope)->
    $scope.step = 1

    $scope.show =
      art_id: null

    $scope.nextStep = (form)->
      if $scope.validate(form)
        $scope.step += 1

    $scope.validate = (form)->
      form.$valid

  ]


