class ShowPaymentController extends @NGController
  @register window.App, 'ShowPaymentController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Show'
    'Picture'
    'Flash'
  ]

  init: ->
    @scope.show = {}
