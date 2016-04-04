###globals define, jQuery, module, require ###

###jslint vars:true ###

###*
# @license angular-bootstrap-datetimepicker  version: 0.4.0
# Copyright 2016 Knight Rider Consulting, Inc. http://www.knightrider.com
# License: MIT
#
# @author        Dale "Ducky" Lotts
# @since        2013-Jul-8
###

((factory) ->
  'use strict'

  ### istanbul ignore if ###

  if typeof define == 'function' and define.amd
    define [
      'angular'
      'moment'
    ], factory
    # AMD

    ### istanbul ignore next ###

  else if typeof exports == 'object'
    module.exports = factory(require('angular'), require('moment'))
    # CommonJS
  else
    factory window.angular, window.moment
    # Browser global
  return
) (angular, moment) ->

  DatetimepickerDirective = (defaultConfig, configurationValidator) ->
    directiveDefinition =
      bindToController: false
      controller: DirectiveController
      controllerAs: 'dateTimePickerController'
      replace: true
      require: 'ngModel'
      restrict: 'E'
      scope:
        beforeRender: '&'
        onSetTime: '&'
      templateUrl: 'directives/datetimepicker.html'

    DirectiveController = ($scope, $element, $attrs) ->
      # Configuration
      ngModelController = $element.controller('ngModel')
      configuration = createConfiguration()

      changeView = (viewName, dateObject, event) ->
        if event
          event.stopPropagation()
          event.preventDefault()
        if viewName and dateObject.utcDateValue > -Infinity and dateObject.selectable and viewToModelFactory[viewName]
          result = viewToModelFactory[viewName](dateObject.utcDateValue)
          weekDates = []
          if result.weeks
            i = 0
            while i < result.weeks.length
              week = result.weeks[i]
              j = 0
              while j < week.dates.length
                weekDate = week.dates[j]
                weekDates.push weekDate
                j += 1
              i += 1
          $scope.beforeRender
            $view: result.currentView
            $dates: result.dates or weekDates
            $leftDate: result.leftDate
            $upDate: result.previousViewDate
            $rightDate: result.rightDate
          $scope.data = result
        return

      yearModelFactory = (milliseconds) ->
        selectedDate = moment.utc(milliseconds).startOf('year')
        # View starts one year before the decade starts and ends one year after the decade ends
        # i.e. passing in a date of 1/1/2013 will give a range of 2009 to 2020
        # Truncate the last digit from the current year and subtract 1 to get the start of the decade
        startDecade = parseInt(selectedDate.year() / 10, 10) * 10
        startDate = moment.utc(startOfDecade(milliseconds)).subtract(1, 'year').startOf('year')
        activeYear = formatValue(ngModelController.$modelValue, 'YYYY')
        result =
          'currentView': 'year'
          'nextView': if configuration.minView == 'year' then 'setTime' else 'month'
          'previousViewDate': new DateObject(
            utcDateValue: null
            display: startDecade + '-' + startDecade + 9)
          'leftDate': new DateObject(utcDateValue: moment.utc(startDate).subtract(9, 'year').valueOf())
          'rightDate': new DateObject(utcDateValue: moment.utc(startDate).add(11, 'year').valueOf())
          'dates': []
        i = 0
        while i < 12
          yearMoment = moment.utc(startDate).add(i, 'years')
          dateValue =
            'utcDateValue': yearMoment.valueOf()
            'display': yearMoment.format('YYYY')
            'past': yearMoment.year() < startDecade
            'future': yearMoment.year() > startDecade + 9
            'active': yearMoment.format('YYYY') == activeYear
          result.dates.push new DateObject(dateValue)
          i += 1
        result

      monthModelFactory = (milliseconds) ->
        startDate = moment.utc(milliseconds).startOf('year')
        previousViewDate = startOfDecade(milliseconds)
        activeDate = formatValue(ngModelController.$modelValue, 'YYYY-MMM')
        result =
          'previousView': 'year'
          'currentView': 'month'
          'nextView': if configuration.minView == 'month' then 'setTime' else 'day'
          'previousViewDate': new DateObject(
            utcDateValue: previousViewDate.valueOf()
            display: startDate.format('YYYY'))
          'leftDate': new DateObject(utcDateValue: moment.utc(startDate).subtract(1, 'year').valueOf())
          'rightDate': new DateObject(utcDateValue: moment.utc(startDate).add(1, 'year').valueOf())
          'dates': []
        i = 0
        while i < 12
          monthMoment = moment.utc(startDate).add(i, 'months')
          dateValue =
            'utcDateValue': monthMoment.valueOf()
            'display': monthMoment.format('MMM')
            'active': monthMoment.format('YYYY-MMM') == activeDate
          result.dates.push new DateObject(dateValue)
          i += 1
        result

      dayModelFactory = (milliseconds) ->
        selectedDate = moment.utc(milliseconds)
        startOfMonth = moment.utc(selectedDate).startOf('month')
        previousViewDate = moment.utc(selectedDate).startOf('year')
        endOfMonth = moment.utc(selectedDate).endOf('month')
        startDate = moment.utc(startOfMonth).subtract(Math.abs(startOfMonth.weekday()), 'days')
        activeDate = formatValue(ngModelController.$modelValue, 'YYYY-MMM-DD')
        result =
          'previousView': 'month'
          'currentView': 'day'
          'nextView': if configuration.minView == 'day' then 'setTime' else 'hour'
          'previousViewDate': new DateObject(
            utcDateValue: previousViewDate.valueOf()
            display: startOfMonth.format('YYYY-MMM'))
          'leftDate': new DateObject(utcDateValue: moment.utc(startOfMonth).subtract(1, 'months').valueOf())
          'rightDate': new DateObject(utcDateValue: moment.utc(startOfMonth).add(1, 'months').valueOf())
          'dayNames': []
          'weeks': []
        dayNumber = 0
        while dayNumber < 7
          result.dayNames.push moment.utc().weekday(dayNumber).format('dd')
          dayNumber += 1
        i = 0
        while i < 6
          week = dates: []
          j = 0
          while j < 7
            monthMoment = moment.utc(startDate).add(i * 7 + j, 'days')
            dateValue =
              'utcDateValue': monthMoment.valueOf()
              'display': monthMoment.format('D')
              'active': monthMoment.format('YYYY-MMM-DD') == activeDate
              'past': monthMoment.isBefore(startOfMonth)
              'future': monthMoment.isAfter(endOfMonth)
            week.dates.push new DateObject(dateValue)
            j += 1
          result.weeks.push week
          i += 1
        result

      hourModelFactory = (milliseconds) ->
        selectedDate = moment.utc(milliseconds).startOf('day')
        previousViewDate = moment.utc(selectedDate).startOf('month')
        activeFormat = formatValue(ngModelController.$modelValue, 'YYYY-MM-DD H')
        result =
          'previousView': 'day'
          'currentView': 'hour'
          'nextView': if configuration.minView == 'hour' then 'setTime' else 'minute'
          'previousViewDate': new DateObject(
            utcDateValue: previousViewDate.valueOf()
            display: selectedDate.format('ll'))
          'leftDate': new DateObject(utcDateValue: moment.utc(selectedDate).subtract(1, 'days').valueOf())
          'rightDate': new DateObject(utcDateValue: moment.utc(selectedDate).add(1, 'days').valueOf())
          'dates': []
        i = 0
        while i < 24
          hourMoment = moment.utc(selectedDate).add(i, 'hours')
          dateValue =
            'utcDateValue': hourMoment.valueOf()
            'display': hourMoment.format('LT')
            'active': hourMoment.format('YYYY-MM-DD H') == activeFormat
          result.dates.push new DateObject(dateValue)
          i += 1
        result

      minuteModelFactory = (milliseconds) ->
        selectedDate = moment.utc(milliseconds).startOf('hour')
        previousViewDate = moment.utc(selectedDate).startOf('day')
        activeFormat = formatValue(ngModelController.$modelValue, 'YYYY-MM-DD H:mm')
        result =
          'previousView': 'hour'
          'currentView': 'minute'
          'nextView': 'setTime'
          'previousViewDate': new DateObject(
            utcDateValue: previousViewDate.valueOf()
            display: selectedDate.format('lll'))
          'leftDate': new DateObject(utcDateValue: moment.utc(selectedDate).subtract(1, 'hours').valueOf())
          'rightDate': new DateObject(utcDateValue: moment.utc(selectedDate).add(1, 'hours').valueOf())
          'dates': []
        limit = 60 / configuration.minuteStep
        i = 0
        while i < limit
          hourMoment = moment.utc(selectedDate).add(i * configuration.minuteStep, 'minute')
          dateValue =
            'utcDateValue': hourMoment.valueOf()
            'display': hourMoment.format('LT')
            'active': hourMoment.format('YYYY-MM-DD H:mm') == activeFormat
          result.dates.push new DateObject(dateValue)
          i += 1
        result

      setTime = (milliseconds) ->
        tempDate = new Date(milliseconds)
        newDate = new Date(tempDate.getUTCFullYear(), tempDate.getUTCMonth(), tempDate.getUTCDate(), tempDate.getUTCHours(), tempDate.getUTCMinutes(), tempDate.getUTCSeconds(), tempDate.getUTCMilliseconds())
        switch configuration.modelType
          when 'Date'
            1
          when 'moment'
            newDate = moment(newDate)
          when 'milliseconds'
            newDate = milliseconds
          else
            # It is assumed that the modelType is a formatting string.
            newDate = moment(newDate).format(configuration.modelType)
        oldDate = ngModelController.$modelValue
        ngModelController.$setViewValue newDate
        if configuration.dropdownSelector
          jQuery(configuration.dropdownSelector).dropdown 'toggle'
        $scope.onSetTime
          newDate: newDate
          oldDate: oldDate
        viewToModelFactory[configuration.startView] milliseconds

      $render = ->
        $scope.changeView configuration.startView, new DateObject(utcDateValue: getUTCTime(ngModelController.$viewValue))
        return

      startOfDecade = (milliseconds) ->
        startYear = parseInt(moment.utc(milliseconds).year() / 10, 10) * 10
        moment.utc(milliseconds).year(startYear).startOf 'year'

      formatValue = (timeValue, formatString) ->
        if timeValue
          getMoment(timeValue).format formatString
        else
          ''

      ###*
      # Converts a time value into a moment.
      #
      # This function is now necessary because moment logs a warning when parsing a string without a format.
      # @param modelValue
      #  a time value in any of the supported formats (Date, moment, milliseconds, and string)
      # @returns {moment}
      #  representing the specified time value.
      ###

      getMoment = (modelValue) ->
        moment modelValue, if angular.isString(modelValue) then configuration.parseFormat else undefined

      ###*
      # Converts a time value to UCT/GMT time.
      # @param modelValue
      #  a time value in any of the supported formats (Date, moment, milliseconds, and string)
      # @returns {number}
      #  number of milliseconds since 1/1/1970
      ###

      getUTCTime = (modelValue) ->
        tempDate = new Date
        if modelValue
          tempMoment = getMoment(modelValue)
          if tempMoment.isValid()
            tempDate = tempMoment.toDate()
          else
            throw 'Invalid date: ' + modelValue
        tempDate.getTime() - (tempDate.getTimezoneOffset() * 60000)

      createConfiguration = ->
        `var configuration`
        directiveConfig = {}
        if $attrs.datetimepickerConfig
          directiveConfig = $scope.$parent.$eval($attrs.datetimepickerConfig)
        configuration = angular.extend({}, defaultConfig, directiveConfig)
        configurationValidator.validate configuration
        configuration

      $scope.screenReader = configuration.screenReader
      # Behavior
      $scope.changeView = changeView
      ngModelController.$render = $render
      if configuration.configureOn
        $scope.$on configuration.configureOn, ->
          configuration = createConfiguration()
          $scope.screenReader = configuration.screenReader
          ngModelController.$render()
          return
      if configuration.renderOn
        $scope.$on configuration.renderOn, ngModelController.$render
      # Implementation
      viewToModelFactory =
        year: yearModelFactory
        month: monthModelFactory
        day: dayModelFactory
        hour: hourModelFactory
        minute: minuteModelFactory
        setTime: setTime
      return

    DateObject = ->
      tempDate = new Date
      localOffset = tempDate.getTimezoneOffset() * 60000
      @utcDateValue = tempDate.getTime()
      @selectable = true

      @localDateValue = ->
        @utcDateValue + localOffset

      validProperties = [
        'utcDateValue'
        'localDateValue'
        'display'
        'active'
        'selectable'
        'past'
        'future'
      ]
      for prop of arguments[0]

        ### istanbul ignore else ###

        #noinspection JSUnfilteredForInLoop
        if validProperties.indexOf(prop) >= 0
          #noinspection JSUnfilteredForInLoop
          @[prop] = arguments[0][prop]
      return

    DirectiveController.$inject = [
      '$scope'
      '$element'
      '$attrs'
    ]
    directiveDefinition

  DateTimePickerConfigProvider = ->
    defaultConfiguration =
      configureOn: null
      dropdownSelector: null
      minuteStep: 5
      minView: 'minute'
      modelType: 'Date'
      parseFormat: 'YYYY-MM-DDTHH:mm:ss.SSSZZ'
      renderOn: null
      startView: 'day'
      timeBegin: '00:00'
      timeEnd: '23:59'
      dateBegin: -Infinity
      dateEnd: Infinity
    defaultLocalization =
      'bg':
        previous: 'предишна'
        next: 'следваща'
      'ca':
        previous: 'anterior'
        next: 'següent'
      'da':
        previous: 'forrige'
        next: 'næste'
      'de':
        previous: 'vorige'
        next: 'weiter'
      'en-au':
        previous: 'previous'
        next: 'next'
      'en-gb':
        previous: 'previous'
        next: 'next'
      'en':
        previous: 'previous'
        next: 'next'
      'es-us':
        previous: 'atrás'
        next: 'siguiente'
      'es':
        previous: 'atrás'
        next: 'siguiente'
      'fi':
        previous: 'edellinen'
        next: 'seuraava'
      'fr':
        previous: 'précédent'
        next: 'suivant'
      'hu':
        previous: 'előző'
        next: 'következő'
      'it':
        previous: 'precedente'
        next: 'successivo'
      'ja':
        previous: '前へ'
        next: '次へ'
      'ml':
        previous: 'മുൻപുള്ളത്'
        next: 'അടുത്തത്'
      'nl':
        previous: 'vorige'
        next: 'volgende'
      'pl':
        previous: 'poprzednia'
        next: 'następna'
      'pt-br':
        previous: 'anteriores'
        next: 'próximos'
      'pt':
        previous: 'anterior'
        next: 'próximo'
      'ro':
        previous: 'anterior'
        next: 'următor'
      'ru':
        previous: 'предыдущая'
        next: 'следующая'
      'sk':
        previous: 'predošlá'
        next: 'ďalšia'
      'sv':
        previous: 'föregående'
        next: 'nästa'
      'tr':
        previous: 'önceki'
        next: 'sonraki'
      'uk':
        previous: 'назад'
        next: 'далі'
      'zh-cn':
        previous: '上一页'
        next: '下一页'
      'zh-tw':
        previous: '上一頁'
        next: '下一頁'
    screenReader = defaultLocalization[moment.locale().toLowerCase()]
    angular.extend {}, defaultConfiguration, screenReader: screenReader

  DateTimePickerValidatorService = ($log) ->

    validator = (configuration) ->
      validOptions = [
        'configureOn'
        'dropdownSelector'
        'minuteStep'
        'minView'
        'modelType'
        'parseFormat'
        'renderOn'
        'startView'
        'screenReader'
      ]
      for prop of configuration
        #noinspection JSUnfilteredForInLoop
        if validOptions.indexOf(prop) < 0
          throw 'invalid option: ' + prop
      # Order of the elements in the validViews array is significant.
      validViews = [
        'minute'
        'hour'
        'day'
        'month'
        'year'
      ]
      if validViews.indexOf(configuration.startView) < 0
        throw 'invalid startView value: ' + configuration.startView
      if validViews.indexOf(configuration.minView) < 0
        throw 'invalid minView value: ' + configuration.minView
      if validViews.indexOf(configuration.minView) > validViews.indexOf(configuration.startView)
        throw 'startView must be greater than minView'
      if !angular.isNumber(configuration.minuteStep)
        throw 'minuteStep must be numeric'
      if configuration.minuteStep <= 0 or configuration.minuteStep >= 60
        throw 'minuteStep must be greater than zero and less than 60'
      if configuration.configureOn != null and !angular.isString(configuration.configureOn)
        throw 'configureOn must be a string'
      if configuration.configureOn != null and configuration.configureOn.length < 1
        throw 'configureOn must not be an empty string'
      if configuration.renderOn != null and !angular.isString(configuration.renderOn)
        throw 'renderOn must be a string'
      if configuration.renderOn != null and configuration.renderOn.length < 1
        throw 'renderOn must not be an empty string'
      if configuration.modelType != null and !angular.isString(configuration.modelType)
        throw 'modelType must be a string'
      if configuration.modelType != null and configuration.modelType.length < 1
        throw 'modelType must not be an empty string'
      if configuration.modelType != 'Date' and configuration.modelType != 'moment' and configuration.modelType != 'milliseconds'
        # modelType contains string format, overriding parseFormat with modelType
        configuration.parseFormat = configuration.modelType
      if configuration.dropdownSelector != null and !angular.isString(configuration.dropdownSelector)
        throw 'dropdownSelector must be a string'

      ### istanbul ignore next ###

      if configuration.dropdownSelector != null and (typeof jQuery == 'undefined' or typeof jQuery().dropdown != 'function')
        $log.error 'Please DO NOT specify the dropdownSelector option unless you are using jQuery AND Bootstrap.js. ' + 'Please include jQuery AND Bootstrap.js, or write code to close the dropdown in the on-set-time callback. \n\n' + 'The dropdownSelector configuration option is being removed because it will not function properly.'
        delete configuration.dropdownSelector
      return

    { validate: validator }

  'use strict'
  angular.module('ui.bootstrap.datetimepicker', []).service('dateTimePickerConfig', DateTimePickerConfigProvider).service('dateTimePickerValidator', DateTimePickerValidatorService).directive 'datetimepicker', DatetimepickerDirective
  DatetimepickerDirective.$inject = [
    'dateTimePickerConfig'
    'dateTimePickerValidator'
  ]
  DateTimePickerValidatorService.$inject = [ '$log' ]
  return

