class ProfileController extends @NGController
  @register window.App, 'ProfileController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'User'
  ]

  user: {}

  init: =>
    google.maps.event.addDomListener(window, 'load', initialize)

    if @rootScope.currentUser
      @User
        .get @rootScope.currentUser.id
        .then (user)=>
          @scope.user = user



