angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', ($rootScope, $scope, $sanitize)->

    $scope.alert = (text)->
       $window.alert(text)

  ]

