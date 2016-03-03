class ShowController extends @NGController
  @register window.App, 'ShowController'

  @$inject: [
    '$scope',
    '$rootScope',
    'Show',
    'Picture',
    'Flash',
    '$sce',
    '$filter',
    'ShowArt',
    'ShowSearch'
  ]

  init: ->
    @scope.step = 1

    @scope.show = {}

    @scope.shows = []
    @scope.arts = []

    @scope.tabsClickable = false

    @scope.filter = {}

    @scope.search = ""

    @scope.$on 'activateAllShows', (e)=>
      angular.forEach @scope.shows, (show, index)=>
        if !show.active
          show
            .toggleActive()
            .then (result)->
              show.active = result.active
      @Flash.closeNotice()

    # schedules
    @scope.$watch 'show.startsAt', (newValue, oldValue)=>
      @scope.show.endsAt = newValue  if newValue > @scope.show.endsAt

    @scope.$watch 'show.endsAt', (newValue, oldValue)=>
      @scope.show.startsAt = newValue  if @scope.show.startsAt > newValue

  load: (id)=>
    if id
      @tabsClickable = true
      @Show
        .get id
        .then (show)=>
          @scope.show = show

          @Picture
            .query { imageable_type: 'Show', imageable_id: @scope.show.id }
            .then (pictures)=>
              @scope.show.pictures = pictures
              # set selected
              for picture in @scope.show.pictures
                picture.selected = true  if picture.id == @scope.show.coverPictureId
                picture._destroy = 0
    else
      @scope.show = new @Show()

  initShows: ()=>
    @Show
      .query()
      .then (shows)=>
        @scope.shows = shows

  nextStep: (form)->
    if @validate(form)
      @scope.step += 1

  prevStep: (form)->
    if @scope.step > 1
      @scope.step -= 1

  validate: (form)->
    # FIXME: change to switch
    return form.$valid  if @scope.step == 1
    return @scope.show.pictures.length > 0  if @scope.step == 2
    return true  if @scope.step == 3 && @scope.show.pictures.filter((picture)->
      picture.selected
    ).length > 0

  removePicture: (index)->
    @scope.show.pictures[index]._destroy = 1

  addShow: (show, index)->
    if angular.isDefined(index)
      @scope.shows[index] = show
    else
      @scope.shows.push(show)
    # Picture
    #   .get(show.coverPictureId)
    #   .then (picture)->
    #     show.coverPicture = picture

  removeShow: (show)->
    if confirm("Are you sure you want to remove this meal?")
      show
        .remove()
        .then =>
          @scope.shows.splice @scope.shows.indexOf(show), 1

  toggleActive: (show, index)=>
    show
      .toggleActive()
      .then (result)=>
        show.active = result.active
        # check all shows for activate
        if result.active
          needActivate = false
          for show in @scope.shows
            if !show.active
              needActivate = true
              break
          if needActivate
            @Flash.showNotice(@scope, 'Some of your ads are not active and are therefore invisible in the search results. Click <a href="#" ng-click="broadcast(\'activateAllShows\')">here</a> for all activate.')
      , (reason)->
        if reason.data.errors.address
          window.location = '/dashboard/profile' + '?flash[error]=' + reason.data.errors.address[0]
        else if reason.data.errors.phone_number
          window.location = '/dashboard/profile' + '?flash[error]=' + reason.data.errors.phone_number[0]

  selectCoverPhoto: (pic)->
    for picture in @scope.show.pictures
      picture.selected = false
    pic.selected = true

  # finish
  finish: ()=>
    @scope.show.pending = true
    @scope.show
      .save()
      .then ()=>
        @scope.show.pending = false
        # redirect to
        window.location = '/dashboard/shows'

  range: (n)->
    new Array(Math.round(n))

  tabClick: (step)->
    if @scope.tabsClickable
      @scope.step = step



