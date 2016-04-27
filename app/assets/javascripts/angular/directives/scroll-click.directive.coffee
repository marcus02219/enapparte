angular
  .module 'enapparte'
  .directive 'scrollOnClick', ->
    {
      restrict: 'A'
      link: (scope, $elm) ->
        $elm.on 'click', ->
          $('body,html').animate { scrollTop: $elm.offset().top }, 'slow'
          return
        return
    }
