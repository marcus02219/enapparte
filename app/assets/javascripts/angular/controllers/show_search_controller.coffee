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
    price: "0,100000"

  init: ->
    @ShowArt
      .query()
      .then (arts)=>
        @scope.arts = arts

    @search()

    @scope.$watch 'filter.price', (newValue, oldValue)=>
      @search()

  search: =>
    q = if  @scope.filter.text then '*' + @scope.filter.text + '*' else ''
    arts = @scope.arts
      .filter (art)->
        art.checked == true
      .map (art)->
        art.id

    @ShowSearch
      .query
        q: q
        price0: @scope.filter.price.split(',')[0]
        price1: @scope.filter.price.split(',')[1]
        arts: JSON.stringify(arts)
      .then (shows)=>
        @scope.shows = shows


