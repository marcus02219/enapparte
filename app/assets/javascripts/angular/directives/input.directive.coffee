angular
  .module 'enapparte'
  .directive 'inputEnum', ()->
    {
      strict: 'E'
      templateUrl: 'directives/input_enum.html'
      scope: {
        dtModel: '='
      }
      replace: true
      link: (scope, element, attrs)->
        scope.dtLabel = attrs.dtLabel
        scope.elementId = 'input_' + scope.$id

        scope.options = []
        enums = JSON.parse(attrs.dtEnum)
        for value, label of enums
          scope.options.push { value: value, label: label }
    }

  .directive 'inputString', ()->
    {
      require: '^form'
      strict: 'E'
      templateUrl: 'directives/input_string.html'
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
    {
      require: '^form'
      strict: 'E'
      templateUrl: 'directives/input_integer.html'
      scope:
        model: '='
      replace: true
      link: (scope, element, attrs, form)->
        scope.form = form
        scope.label = attrs.label
        scope.elementId = 'input_' + scope.$id
        scope.required = attrs.required != undefined
    }

  .directive 'inputSelect', ()->
    {
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
    }
