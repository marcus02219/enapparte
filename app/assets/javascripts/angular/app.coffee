@App = angular
  .module 'enapparte', [
    'rails'
    'ngRoute'
    'ngSanitize'
    'cgNotify'
    'angularUtils.directives.dirPagination'
    'underscore'
    'angularMoment'
    'ui.bootstrap'
    'Devise'
    'focus-if'
  ]

@App.config ['AuthProvider', (AuthProvider)->
]

@App.config ['$routeProvider', ($routeProvider)->
  $routeProvider
    .when '/show/new',
      templateUrl: 'show/new.html'
      controller: 'ShowController'
    .otherwise
      redirectTo: ()=>
        window.location.href = '/'
]

@App.config ["$httpProvider", ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ]

@App.run ['$rootScope', 'Auth', ($rootScope, Auth)->
  Auth.currentUser().then (user)->
    $rootScope.currentUser = user

  $rootScope.flash = null
]


