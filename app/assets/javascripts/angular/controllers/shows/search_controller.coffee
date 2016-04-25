class ShowSearchController extends @NGController
  @register window.App, 'ShowSearchController'

  @$inject: [
    '$scope',
    '$rootScope',
    'Show',
    'Picture',
    'Flash',
    '$filter',
    'ShowArt',
    'ShowSearch',
    '_'
    'moment'
    'Auth'
    '$state'
    '$stateParams'
  ]

  shows: []
  arts: []
  filter:
    text: ""
    price: "0,100000"

  init: ->

    if @stateParams.id
      console.log @stateParams.title
      art_id  = @stateParams.id
      @ShowSearch
        .query
          arts: JSON.stringify([art_id])
        .then (shows)=>
          @scope.shows = shows
    else
      @ShowArt
        .query()
        .then (arts)=>
          @scope.arts = arts

      @scope.$watch 'filter.price', (newValue, oldValue)=>
        @search()

  search: =>
    q = if  @scope.filter.text then '*' + @scope.filter.text + '*' else ''
    art_ids = @scope.arts
      .filter (art)->
        art.checked == true
      .map (art)->
        art.id

    @ShowSearch
      .query
        q: q
        price0: @scope.filter.price.split(',')[0]
        price1: @scope.filter.price.split(',')[1]
        arts: JSON.stringify(art_ids)
      .then (shows)=>
        @scope.shows = shows

  modeDetails: (show)=>
    console.log show.id
    @state.go 'shows.detail',
      id: show.id
      show: show



