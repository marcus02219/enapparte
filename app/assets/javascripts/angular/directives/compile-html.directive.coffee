angular
  .module('enapparte')
  .directive 'compileHtml', ['$compile', ($compile)->
    {
      link: (scope, element, attrs) ->
        scope.$watch (scope) ->
          scope.$eval(attrs.compileHtml)
        , (value) ->
          element.html value
          $compile(element.contents())(scope)
    }
  ]
