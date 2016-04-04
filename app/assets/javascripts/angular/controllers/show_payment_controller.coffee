class ShowPaymentController extends @NGController
  @register window.App, 'ShowPaymentController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Show'
    'Flash'
    '$state'
    '$stateParams'
  ]

  show: {}

  init: ()=>
    id = @stateParams.id
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
