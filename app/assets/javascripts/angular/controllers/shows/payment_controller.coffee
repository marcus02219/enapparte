class ShowPaymentController extends @NGController
  @register window.App, 'ShowPaymentController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Show'
    'User'
    'Flash'
    '$state'
    '$stateParams'
  ]

  show: {}
  booking: {
    date: null
    spectators: null
  }

  init: ()=>
    id = @stateParams.id
    @scope.booking.date = moment.unix(@stateParams.date)
    @scope.booking.spectators = @stateParams.spectators
    @User
      .get(1)
      .then (user)=>
        @scope.user = user
    if @stateParams.show
      @scope.show = @stateParams.show
    else
      if id
        @Show
          .get id
          .then (show)=>
            @scope.show = show

            # set selected
            for picture in @scope.show.pictures
              picture.selected = true  if picture.id == @scope.show.coverPictureId
              picture._destroy = 0
      else
        # @window.location.href = '/'

  booking: ()=>
    @scope.$watchGroup [ 'user.address', 'user.payment' ], (newValues)=>
      console.log newValues
      if newValues[0] && newValues[1]
        console.log @scope.user.address
        console.log @scope.user.payment

