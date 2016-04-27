class RootController extends @NGController
  @register window.App, 'RootController'

  @$inject: [
    '$scope',
    '$rootScope',
    '$state',
    'Art'
  ]

  init: ->
    @rootScope.rootPath = true
    @scope.arts = []
    @Art
      .query()
      .then (art)=>
        @scope.arts = art
    $('#header')
      .removeClass('not-fixed')
      .addClass('affix-top')
      .affix
        offset:
          top: 490
    $("#content-main-page").addClass("full-main-content")
    @scope.valueSelect = null
  beginSearch: =>
    @state.go 'shows.search',
      id: @scope.valueSelect
