angular
  .module 'enapparte'
  .controller 'ShowController', ['$scope', 'Show', 'Picture', ($scope, Show, Picture)->
    $scope.step = 1

    $scope.show = {}

    $scope.init = (id)->
      if id
        Show.get { id: id }, (show)->
          $scope.show = show

          Picture.query { imageable_type: 'Show', imageable_id: show.id },
            success: (pictures)->
              console.log pictures
      else
        $scope.show = new Show()

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

    # schedules
    $scope.$watch 'show.starts_at', (newValue, oldValue)->
      $scope.show.ends_at = newValue  if newValue > $scope.show.ends_at

    $scope.$watch 'show.ends_at', (newValue, oldValue)->
      $scope.show.starts_at = newValue  if $scope.show.starts_at > newValue

    # finish
    $scope.finish = ()->
      show = new Show({ show: $scope.show })
      console.log show.$save()

      # redirect to
      window.location = '/dashboard/shows'

  ]


