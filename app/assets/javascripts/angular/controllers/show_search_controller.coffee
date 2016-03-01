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
  show: null

  filter:
    text: ""
    price: "0,100000"

  mode: 'list'

  init: ->
    @ShowArt
      .query()
      .then (arts)=>
        @scope.arts = arts

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
        # @scope.show = shows.first

  modeDetails: (show)=>
    @scope.mode = 'detail'
    @scope.show = show

  modeList: ()=>
    @scope.mode = 'list'

  changePicture: (picture)=>
    @scope.show.coverPicture = picture





