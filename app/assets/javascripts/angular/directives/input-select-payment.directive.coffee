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
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.cardNumberId = 'input_card_number_' + scope.$id
      scope.cardCvcId = 'input_card_cvc_' + scope.$id
      scope.cardExpMonthId = 'input_card_exp_month_' + scope.$id
      scope.cardExpYearId = 'input_card_exp_year_' + scope.$id
      scope.required = false
      scope.selectedPaymentMethod = {}
      scope.card = {}

      scope.$watch 'form.$submitted', (newValue)->
        if newValue
          # create Stripe Token
          Stripe.card.createToken {
            number: scope.card.number
            cvc: scope.card.cvc
            exp_month: scope.card.exp_month
            exp_year: scope.card.exp_year
          }, scope.stripeResponseHandler

      scope.stripeResponseHandler = (status, response)->
        if response.error
          Flash.showError scope, response.error.message
        else
          scope.$apply ->
            scope.selectedPaymentMethod.stripeToken = response.id
            scope.selectedPaymentMethod.last4 = response.card.last4
            scope.selectedPaymentMethod.new = false

      scope.$watch 'selectedPaymentMethod', (newValue)=>
        if newValue
          if newValue.new
            $("#google-address").focus()
            $("#google-address")[0].select()
          else
            scope.model = newValue
            console.log scope.model

      scope.$watch 'paymentMethods', (paymentMethods)=>
        if paymentMethods instanceof Array
          paymentMethods.push { last4: 'Add new payment', new: true }
          scope.selectedPaymentMethod = paymentMethods[0]

