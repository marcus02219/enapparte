angular
  .module 'enapparte'
  .directive 'inputSelectPayment', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input-select-payment.html'
    scope:
      model: '='
      paymentMethods: '='
    replace: true
    transclude: true
    link: (scope, element, attrs, form)->
