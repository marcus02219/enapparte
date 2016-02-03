angular
  .module 'enapparte'
  .controller 'ShowController', ['$scope', ($scope)->
    $scope.step = 4

    $scope.show =
      art_id: null
      pictures: []

    $scope.nextStep = (form)->
      if $scope.validate(form)
        $scope.step += 1

    $scope.validate = (form)->
      return form.$valid  if $scope.step == 1
      return $scope.show.pictures.length > 0  if $scope.step == 2
      return true  if $scope.step == 3 && $scope.show.pictures.filter((picture)->
        picture.selected
      ).length > 0

    $scope.removePicture = (index)->
      $scope.show.pictures.splice index, 1

    $scope.selectCoverPhoto = (pic)->
      for picture in $scope.show.pictures
        picture.selected = false
      pic.selected = true

  ]


