angular
  .module 'enapparte'
  .directive 'inputSelectPayment', ['$timeout', ($timeout)->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input-select-payment.html'
    scope:
      model: '='
      paymentMethods: '='
      card: '='
    replace: true
    transclude: true
    link: (scope, element, attrs, form)->
      scope.options = []
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.cardNumberId = 'input_card_number_' + scope.$id
      scope.cardCvcId = 'input_card_cvc_' + scope.$id
      scope.cardExpMonthId = 'input_card_exp_month_' + scope.$id
      scope.cardExpYearId = 'input_card_exp_year_' + scope.$id
      scope.required = false
      scope.selectedPaymentMethod = {}

      scope.$watch 'selectedPaymentMethod', (newValue)=>
        if newValue && newValue.new
          $timeout ()->
            $("#" + scope.cardNumberId).focus()
          , 200

      scope.$watch 'paymentMethods', (newValue)=>
        if newValue instanceof Array
          scope.options = angular.copy newValue
          scope.options.push { last4: 'Add new payment', new: true }
          scope.selectedPaymentMethod = scope.options[0]
          scope.model = scope.options[0]
  ]
