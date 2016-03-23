angular
  .module 'enapparte'
  .directive 'inputEnum', ()->
    strict: 'E'
    templateUrl: 'directives/input_enum.html'
    scope:
      dtModel: '='
    replace: true
    link: (scope, element, attrs)->
      scope.dtLabel = attrs.dtLabel
      scope.elementId = 'input_' + scope.$id

      scope.options = []
      enums = JSON.parse(attrs.dtEnum)
      for value, label of enums
        scope.options.push { value: value, label: label }

  .directive 'inputString', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_string.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined
      scope.focus = attrs.focus != undefined
      scope.hint = attrs.hint

  .directive 'inputText', ()->
    {
      require: '^form'
      strict: 'E'
      templateUrl: 'directives/input_text.html'
      scope: {
        model: '='
      }
      replace: true
      link: (scope, element, attrs, form)->
        scope.form = form
        scope.label = attrs.label
        scope.elementId = 'input_' + scope.$id
        scope.required = attrs.required != undefined
    }

  .directive 'inputDate', ()->
    {
      strict: 'E'
      templateUrl: 'directives/input_date.html'
      scope: {
        model: '='
      }
      replace: true
      link: (scope, element, attrs)->
        scope.label = attrs.label
        scope.elementId = 'input_' + scope.$id
        scope.elementDayId = scope.elementId + '-day'
        scope.elementMonthId = scope.elementId + '-month'
        scope.elementYearId = scope.elementId + '-year'
        scope.required = attrs.required != undefined

        scope.$watch 'model', (newValue, oldValue)->
          unless oldValue
            scope.day = moment(newValue).date()
            scope.month = moment(newValue).month() + 1
            scope.year = moment(newValue).year()

        scope.$watchGroup ['day', 'month', 'year'], ()->
          if scope.model
            scope.model = moment([scope.year, scope.month - 1, scope.day + 1]).toDate()

        scope.days = [1..31]
        scope.monthes = [1..12]
        scope.monthNames = []
        for month in scope.monthes
          scope.monthNames.push moment().month(month-1).format("MMMM")
        currentYear = new Date().getFullYear()
        scope.years = [currentYear - 70..currentYear - 5].reverse()
    }

  .directive 'inputInteger', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_integer.html'
    scope:
      model: '='
      max: '='
      min: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined

  .directive 'inputSelect', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_select.html'
    scope: {
      model: '='
    }
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.options = element.data('collection')
      scope.required = attrs.required != undefined

      scope.$watch 'model', (newValue, oldValue)->
        unless oldValue
          for option in scope.options
            if option.value == newValue
              scope.selectedOption = option

      scope.$watch 'selectedOption', (newValue)->
        if scope.selectedOption
          scope.model = scope.selectedOption.value

  .directive 'inputImage', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_image.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined
      scope.model = []  unless scope.model

      element.bind 'change', (changeEvent) ->
        for file in changeEvent.target.files
          reader = new FileReader()

          reader.onload = (loadEvent) ->
            scope.$apply ->
              scope.model.push { src: loadEvent.target.result }

          reader.readAsDataURL file

  .directive 'inputImageButton', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_image_button.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined

      element.bind 'change', (changeEvent) ->
        for file in changeEvent.target.files
          reader = new FileReader()

          reader.onload = (loadEvent) ->
            scope.$apply ->
              scope.model = { src: loadEvent.target.result }

          reader.readAsDataURL file

  .directive 'inputImagesButton', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_images_button.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined
      scope.model = []  unless scope.model

      element.bind 'change', (changeEvent) ->
        for file in changeEvent.target.files
          reader = new FileReader()

          reader.onload = (loadEvent) ->
            scope.$apply ->
              scope.model.push { src: loadEvent.target.result }

          reader.readAsDataURL file

  .directive 'inputTime', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_time.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined

      scope.options = []
      for h in [0..23]
        for min in [0, 30]
          time = ('0' + h).slice(-2) + ':' + ('0' + min).slice(-2)
          scope.options.push { name: time, value: time }

  .directive 'inputDatetime', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_datetime.html'
    scope:
      model: '='
      startDate: '@'
      endDate: '@'
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined

      element.find('input').datetimepicker
        format: attrs.dateFormat
        autoclose: true

      scope.$watch 'startDate', (newValue)->
        element.find('input').datetimepicker 'setStartDate', moment(newValue).toDate()

      scope.$watch 'endDate', (newValue)->
        element.find('input').datetimepicker 'setEndDate', moment(newValue).toDate()

      element.find('input').datetimepicker 'update', scope.model
        .on 'changeDate', (e)->
          scope.$apply ->
            scope.model = e.date

  .directive 'inputEmail', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_email.html'
    scope: {
      model: '='
    }
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined
      scope.focus = attrs.focus != undefined
      scope.disabled = attrs.disabled != undefined

  .directive 'inputPassword', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_password.html'
    scope: {
      model: '='
    }
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.elementConfirmationId = 'input_confirmation_' + scope.$id
      scope.required = attrs.required != undefined
      scope.confirmation = attrs.confirmation != undefined

      if scope.confirmation
        scope.data =
          confirmation: null
        scope.$watch 'data.confirmation', (newValue)->
          scope.form[scope.elementConfirmationId].$setValidity 'confirmation', scope.model == scope.data.confirmation
        scope.$watch 'model', (newValue)->
          scope.form[scope.elementConfirmationId].$setValidity 'confirmation', scope.model == scope.data.confirmation

  .directive 'inputBoolean', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input-boolean.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined

  .directive 'inputRadio', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input-radio.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.options = JSON.parse attrs.collection
      scope.required = attrs.required != undefined

      scope.data =
        model: null

      scope.$watch 'data.model', (newValue)->
        scope.model = newValue

  .directive 'inputPhone', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_phone.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined
      scope.focus = attrs.focus != undefined
      scope.hint = attrs.hint

      # IntlTelInput
      element.find('input').intlTelInput
        onlyCountries: ["fr"]
        initialCountry: "fr"
        preferredCountries: "fr"

  .directive 'inputSelectAddress', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input-select-address.html'
    scope:
      model: '='
      addresses: '='
    replace: true
    transclude: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = false
      scope.addressId = scope.addresses[0].id  if scope.addresses && scope.addresses[0]

      scope.$watch 'addressId', (newValue)=>
        scope.model = {}
        angular.forEach scope.addresses, (address)=>
          if "" + address.id == newValue
            scope.model = address
