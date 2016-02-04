angular
  .module 'enapparte'
  .controller 'TabsController', ($scope)->
    $scope.panes = []

    $scope.selectPane = (pane)->
      for p in $scope.panes
        p.active = false
      pane.active = true

    addPane: (pane)->
      pane.active = true  if $scope.panes.length == 0
      $scope.panes.push pane


