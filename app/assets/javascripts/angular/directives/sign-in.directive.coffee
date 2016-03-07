angular
  .module 'enapparte'
  .directive 'signIn', ()->
    strict: 'E'
    templateUrl: 'devise/log_in.html'
    replace: true
    transclude: true
