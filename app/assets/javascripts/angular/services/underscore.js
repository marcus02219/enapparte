var underscore = angular.module('underscore', []);
underscore.factory('_', ['$window', function() {
  return $window._;
}]);
