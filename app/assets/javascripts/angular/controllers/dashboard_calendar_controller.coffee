class DashboardCalendarController extends @NGController
  @register window.App, 'DashboardCalendarController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'User'
    '$state'
    'Show'
    '$stateParams'
  ]

  shows = []
  showId = ""
  init: ->
    @Show
      .query()
      .then (shows)=>
        shows = _.filter shows, (show)->
          show.start != ""
        shows = _.uniq shows, (show)->
          d = new Date(show.start)
          d.toDateString()
        @scope.shows = shows
    if @stateParams.id
      @scope.showId = @stateParams.id
