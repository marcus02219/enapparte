class ShowDetailController extends @NGController
  @register window.App, 'ShowDetailController'

  @$inject: [
    '$scope',
    '$rootScope',
    'Show',
    'Picture',
    'Flash',
    '$filter',
    'ShowArt',
    'ShowSearch',
    '_'
    'moment'
    'Auth'
    '$state'
    '$stateParams'
  ]

  show: null
  booking:
    startDate: moment().add(3, 'd').format()
    date: moment().add(3, 'd').toDate()
    spectators: 1

  init: ->
    if @stateParams.show
      @scope.show = @stateParam.show
    else
      if @stateParams.id
        @Show
          .get @stateParams.id
          .then (show)=>
            @scope.show = show

  changePicture: (picture)=>
    @scope.show.coverPicture = picture

  nextPicture: ()=>
    index = _.indexOf @scope.show.pictures, @scope.show.coverPicture
    @scope.show.coverPicture = if index >= 0 && index < @scope.show.pictures.length - 1
      @scope.show.pictures[index + 1]
    else
      @scope.show.pictures[0]

  prevPicture: ()=>
    index = _.indexOf @scope.show.pictures, @scope.show.coverPicture
    @scope.show.coverPicture = if index > 0 && index <= @scope.show.pictures.length - 1
      @scope.show.pictures[index - 1]
    else
      _.last @scope.show.pictures

  payment: ()->
    @state.go 'shows.payment',
      id: @scope.show.id
      date: moment(@scope.booking.date).unix()
      spectators: @scope.booking.spectators
      show: @scope.show

  submitBooking: ()=>
    unless @Auth.isAuthenticated()
      @rootScope
        .showSignIn()
        .result.then (result)=>
          @payment()
    else
      @payment()
