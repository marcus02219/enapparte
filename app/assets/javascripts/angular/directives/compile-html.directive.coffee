angular
  .module('enapparte')
  .directive 'compileHtml', ['$compile', ($compile)->
    {
      restrict: 'A'
      replace: true
      link: (scope, element, attrs) ->
        scope.$watch attrs.compileHtml, (html) ->
          element.html html
          $compile(element.contents())(scope)
    }
  ]
