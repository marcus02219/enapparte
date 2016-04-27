angular
  .module 'enapparte'
  .directive 'scrollOnClick', ->
    {
      restrict: 'A'
      link: (scope, $elm) ->
        $elm.on 'click', ->
          $('body').animate { scrollTop: $elm.offset().top }, 'slow'
          return
        return
    }
