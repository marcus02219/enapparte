class ShowSearchController extends @NGController
  @register window.App

  @$inject: [
    '$scope',
    '$rootScope',
    'Show',
    'Picture',
    'Flash',
    '$filter',
    'ShowArt',
    'ShowSearch'
  ]

  shows: []
  arts: []

  filter:
    text: ""
    price: [0, 100000]

  init: ->
    @ShowArt
      .query()
      .then (arts)=>
        @scope.arts = arts

    @search()

  search: =>
    @ShowSearch
      .query(q: '*' + @scope.filter.text + '*')
      .then (shows)=>
        @scope.shows = shows

