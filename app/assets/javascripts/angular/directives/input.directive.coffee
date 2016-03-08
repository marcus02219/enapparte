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
        dtModel: '='
      }
      replace: true
      link: (scope, element, attrs)->
        scope.dtLabel = attrs.dtLabel
        scope.elementId = 'input_' + scope.$id

        scope.day = 1
        scope.month = 1
        scope.year = 2000

        scope.days = [1..31]
        scope.monthes = []
        month_names = JSON.parse(attrs.dtMonthes)
        for month in [1..12]
          scope.monthes.push { label: month_names[month], value: month }
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
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.options = element.data('collection')
      scope.required = attrs.required != undefined

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

  .directive 'inputPassword', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input_password.html'
    scope:
      model: '='
    replace: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = attrs.required != undefined
      scope.confirmation = attrs.confirmation != undefined

      if scope.confirmation
        scope.passwordConfirmation = ""
        scope.$watch 'passwordConfirmation', (newValue)->
          console.log newValue
          scope.form[scope.elementId].$setValidity 'confirmation', scope.model != newValue

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


