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
    .when '/shows/new',
      templateUrl: 'shows/new.html'
    .when '/shows',
      templateUrl: 'shows/index.html'
    .when '/shows/payment',
      templateUrl: 'shows/payment.html'
    .otherwise
      templateUrl: 'root.html'
      controller: 'RootController'
]

@App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

@App.run ['$rootScope', 'Auth', ($rootScope, Auth)->
  Auth.currentUser().then (user)->
    $rootScope.currentUser = user

  $rootScope.$on '$routeChangeStart', (e)->
    console.log e
    $rootScope.rootPath = false
    $(window).off('.affix')
    $("#header")
        .removeClass("affix affix-top affix-bottom")
        .addClass("not-fixed")
        .removeData("bs.affix")
]


