class ProfileController extends @NGController
  @register window.App, 'ProfileController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'User'
    '$state'
  ]

  tabs2: [
    { heading: 'Personal', route: 'dashboard.profile.personal', active: true }
    { heading: 'Reviews', route: 'dashboard.profile.reviews', active: false }
  ]

  go: (route)=>
    console.log route
    @state.go route

  user: {}
  map: null

  init: =>
    @User
      .get(1)
      .then (user)=>
        @scope.user = user

  userSave: =>
    if @scope.user
      @scope.user.save()
        .then (user)=>
          @scope.user = user
          @Flash.showNotice @scope, 'User was saved successfully.'
        , (error)->
          console.log error
          # @Flash.showError @scope, 'User was saved successfully.'

