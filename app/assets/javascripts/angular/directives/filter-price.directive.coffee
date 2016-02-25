angular
  .module 'enapparte'
  .directive 'filterPrice', ()->
    {
      strict: 'E'
      templateUrl: 'directives/filter-price.html'
      scope: {
        model: '='
        min: '='
        max: '='
      }
      replace: true
      link: (scope, element, attrs)->
        scope.elementId = 'filter-' + scope.$id
        element
          .find('input')
          .slider
            min: scope.min
            max: scope.max
            value: [scope.min, scope.max]
          .on 'slideStop', ()->
            scope.$apply ->
              scope.model = scope.value

    }
