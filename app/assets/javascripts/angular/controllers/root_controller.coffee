class RootController extends @NGController
  @register window.App, 'RootController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$route'
  ]

  init: ->
    @rootScope.rootPath = true
    $('#header')
      .removeClass('not-fixed')
      .addClass('affix-top')
      .affix
        offset:
          top: 490
