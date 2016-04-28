class RootController extends @NGController
  @register window.App, 'RootController'

  @$inject: [
    '$scope',
    '$rootScope',
    '$state',
    'Art'
  ]

  init: ->
    @scope.art = {}
    @rootScope.rootPath = true
    @scope.arts = []
    @Art
      .query()
      .then (art)=>
        @scope.arts = art
    @scope.art.selected = @scope.arts[0]
    $('#header')
      .removeClass('not-fixed')
      .addClass('affix-top')
      .affix
        offset:
          top: 490
    $("#content-main-page").addClass("full-main-content")
  beginSearch: =>
    idArt = @scope.art.selected.id if @scope.art.selected
    @state.go 'shows.search',
      id: idArt || null
