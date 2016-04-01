@App = angular
  .module 'enapparte', [
    'rails'
    'ngSanitize'
    'cgNotify'
    'angularUtils.directives.dirPagination'
    'underscore'
    'angularMoment'
    'ui.bootstrap'
    'Devise'
    'focus-if'
    'ui.router'
    'ui.router.tabs'
  ]

@App.config ['AuthProvider', (AuthProvider)->
]

@App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

@App.run ['$rootScope', 'Auth', ($rootScope, Auth)->
  Auth.currentUser().then (user)->
    $rootScope.currentUser = user

  $rootScope.$on '$stateChangeStart', (e)->
    $rootScope.rootPath = false
    $(window).off('.affix')
    $("#header")
        .removeClass("affix affix-top affix-bottom")
        .addClass("not-fixed")
        .removeData("bs.affix")
]

@App.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider)->
  $urlRouterProvider.otherwise('/')

  $stateProvider
    .state 'home',
      url: '/'
      templateUrl: 'root.html'
      controller: 'RootController'

    .state 'shows', { abstract: true, url: '/shows', templateUrl: 'shows/index.html' }
    .state 'shows.search', { url: '/search', templateUrl: 'shows/search.html' }
    .state 'shows.payment', { url: '/:id/payment', templateUrl: 'shows/payment.html', params: { show: null } }
    .state 'shows.edit', { url: '/edit', templateUrl: 'shows/edit.html', params: { id: null } }

    .state 'dashboard', { abstract: true, url: '/dashboard', templateUrl: 'dashboard/tabs.html' }
      .state 'dashboard.index', { url: '/dashboard', templateUrl: 'dashboard/index.html' }

      .state 'dashboard.profile', { abstract: true, url: '/profile', templateUrl: 'dashboard/profile/tabs.html' }
      .state 'dashboard.profile.personal', { url: '/personal', templateUrl: 'dashboard/profile/personal.html' }
      .state 'dashboard.profile.reviews', { abstract: true, url: '/reviews', templateUrl: 'dashboard/profile/reviews/tabs.html' }
      .state 'dashboard.profile.reviews.received', { url: '/received', templateUrl: 'dashboard/profile/reviews/received.html' }
      .state 'dashboard.profile.reviews.sent', { url: '/sent', templateUrl: 'dashboard/profile/reviews/sent.html' }

      .state 'dashboard.messages', { url: '/messages', templateUrl: 'dashboard/messages/index.html' }

      .state 'dashboard.shows', { url: '/shows', templateUrl: 'dashboard/shows/index.html' }

      .state 'dashboard.performances', { abstract: true, url: '/performances', templateUrl: 'dashboard/performances/index.html' }
      .state 'dashboard.performances.current', { url: '/current', templateUrl: 'dashboard/performances/current.html' }
      .state 'dashboard.performances.history', { url: '/history', templateUrl: 'dashboard/performances/history.html' }
      .state 'dashboard.performances.cancelled', { url: '/cancelled', templateUrl: 'dashboard/performances/cancelled.html' }
]

