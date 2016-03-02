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
        @scope.show = shows[2]

  modeDetails: (show)=>
    @scope.mode = 'detail'
    @scope.show = show

  modeList: ()=>
    @scope.mode = 'list'

  changePicture: (picture)=>
    @scope.show.coverPicture = picture

  nextPicture: ()=>
    index = _.indexOf @scope.show.pictures, @scope.show.coverPicture
    @scope.show.coverPicture = if index >= 0 && index < @scope.show.pictures.length - 1
      @scope.show.pictures[index + 1]
    else
      @scope.show.pictures[0]

  prevPicture: ()=>
    index = _.indexOf @scope.show.pictures, @scope.show.coverPicture
    @scope.show.coverPicture = if index > 0 && index <= @scope.show.pictures.length - 1
      @scope.show.pictures[index - 1]
    else
      _.last @scope.show.pictures




