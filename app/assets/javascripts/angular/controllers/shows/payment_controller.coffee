class ShowPaymentController extends @NGController
  @register window.App, 'ShowPaymentController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Show'
    'User'
    'Booking'
    'Flash'
    '$state'
    '$stateParams'
  ]

  show: {}
  booking: {
    date: null
    spectators: null
    message: null
  }
  card: {}

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

  bookingCreate: ()=>
    @scope.user.save()
      .then (user)=>
        new @Booking(
          status: 2
          date: @scope.booking.date.toDate()
          spectators: @scope.booking.spectators
          price: @scope.show.price * @scope.show.commission
          message: @scope.booking.message
          addressId: @scope.user.address.id
          paymentId: @scope.user.payment.id
          showId: @scope.show.id
        ).create()
          .then (booking)=>
            @Flash.showNotice @scope, 'Booking saved successfully!'
          , (error)->
            console.log error
      , (error)->
        console.log error

  booking: (form)=>
    if form.$valid && @scope.user
      if @scope.user.payment.new
        # Stripe
        Stripe.card.createToken {
          number: @scope.card.number
          cvc: @scope.card.cvc
          exp_month: @scope.card.exp_month
          exp_year: @scope.card.exp_year
        }, (status, response)=>
          if response.error
            Flash.showError @scope, response.error.message
          else
            selected = {}
            selected.stripeToken = response.id
            selected.last4 = response.card.last4
            selected.new = false
            @scope.user.paymentMethods.push selected
            @scope.user.payment = selected
            @scope.bookingCreate()
      else
        @scope.bookingCreate()

