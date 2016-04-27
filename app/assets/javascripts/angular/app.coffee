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
    'ui.bootstrap.datetimepicker'
    'ngAnimate'
    'anim-in-out'
    'stripe'
    'credit-cards'
    'ui.select'
  ]

@App.config ['AuthProvider', (AuthProvider)->
]

@App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

@App.config ['uiSelectConfig', (uiSelectConfig) ->
  uiSelectConfig.theme = 'bootstrap'
]

# @App.config ['dateTimePickerConfig', (dateTimePickerConfig)->
#   # dateTimePickerConfig.defaults
# ]

@App.config [()->
  Stripe.setPublishableKey(window.StripePublishableKey)
]

@App.run ['$rootScope', 'Auth', '$state', ($rootScope, Auth, $state)->
  Auth.currentUser().then (user)->
    $rootScope.currentUser = user

  $rootScope.$on '$stateChangeSuccess', (e)->
    $rootScope.rootPath = false
    $(window).off('.affix')
    unless $state.current.name.startsWith 'home'
      $("#header")
          .removeClass("affix,affix-top, affix-bottom, full-main-content")
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
    .state 'shows.search', { url: '/:id/search', templateUrl: 'shows/search.html' }
    .state 'shows.detail', { url: '/:id/detail', templateUrl: 'shows/detail.html' }
    .state 'shows.payment', { url: '/:id/payment?date&spectators', templateUrl: 'shows/payment.html', params: { show: null } }
      .state 'shows.payment_finish', { url: '/payment_finish', templateUrl: 'shows/payment_finish.html' }
    .state 'shows.edit', { url: '/edit', templateUrl: 'shows/edit.html', params: { id: null } }

    .state 'dashboard', { abstract: true, url: '/dashboard', templateUrl: 'dashboard/tabs.html' }
      .state 'dashboard.index', { url: '/index', templateUrl: 'dashboard/index.html' }

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

      .state 'dashboard.reservations', { abstract: true, url: '/reservations', templateUrl: 'dashboard/reservations/index.html' }
      .state 'dashboard.reservations.current', { url: '/current', templateUrl: 'dashboard/reservations/current.html' }
      .state 'dashboard.reservations.history', { url: '/history', templateUrl: 'dashboard/reservations/history.html' }
      .state 'dashboard.reservations.cancelled', { url: '/cancelled', templateUrl: 'dashboard/reservations/cancelled.html' }

      .state 'dashboard.account', { abstract: true, url: '/account', templateUrl: 'dashboard/account/index.html' }
      .state 'dashboard.account.payment', { url: '/payment', templateUrl: 'dashboard/account/payment.html' }
      .state 'dashboard.account.information', { url: '/information', templateUrl: 'dashboard/account/information.html' }
      .state 'dashboard.account.security', { url: '/security', templateUrl: 'dashboard/account/security.html' }

    .state 'home.signin', {
      url: 'signin',
      onEnter: ['$uibModal', '$state', ($uibModal, $state)->
        $uibModal.open
          animation: true
          templateUrl: 'devise/log_in.html'
          controller: 'SignInController'
        .result
        .finally ()->
          $state.go '^'
      ]
    }
    .state 'home.signup', {
      url: 'signup',
      onEnter: ['$uibModal', '$state', ($uibModal, $state)->
        $uibModal.open
          animation: true
          templateUrl: 'devise/sign_up.html'
          controller: 'SignUpController'
        .result
        .finally ()->
          $state.go '^'
      ]
    }
]

