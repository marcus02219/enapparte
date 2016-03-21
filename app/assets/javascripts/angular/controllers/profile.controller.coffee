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
    if @rootScope.currentUser
      @User
        .get @rootScope.currentUser.id
        .then (user)=>
          @scope.user = user
          google_maps_initialize()

