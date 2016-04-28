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
    { heading: 'Personal', route: 'dashboard.profile.personal' }
    { heading: 'Reviews', route: 'dashboard.profile.reviews.received', routeActive: 'dashboard.profile.reviews' }
  ]

  tabsReviews: [
    { heading: 'Received', route: 'dashboard.profile.reviews.received' }
    { heading: 'Sent', route: 'dashboard.profile.reviews.sent' }
  ]

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
          # @Flash.showError @scope, 'User was saved successfully.'

