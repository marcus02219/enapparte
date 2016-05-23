class DashboardCalendarController extends @NGController
  @register window.App, 'DashboardCalendarController'

  @$inject: [
    '$scope'
    '$http'
    '$element'
    '$rootScope'
    'Flash'
    '$state'
    'User_availabilities'
    '$stateParams'
  ]

  shows = []
  showId = ""
  events = []
  index = 1
  first_available_month = 0
  init: ->
    @User_availabilities
      .query()
      .then (user_availabilities)=>
        i = 0
        while i < user_availabilities.length
          event ={'id':"", 'available_at':"", 'start':""}
          event['id'] = user_availabilities[i].id
          event['available_at'] = user_availabilities[i].available_at
          event['start'] = user_availabilities[i].available_at
          events.push event
          i++
        @scope.shows = events
        if @stateParams.id
          @scope.showId = @stateParams.id

  insert_available_date: ()=>
    availability = {available_at:@scope.available_at}
    scope = @scope
    @http(
        method: 'POST'
        url: '/api/v1/availabilities'
        data: {availability:availability}).then ((response) ->
          event = [{'id':response.id, 'available_at':response.available_at, 'start':response.available_at}]
          scope.event_param = event
          scope.$broadcast 'insert_success', event
          console.log "insert success controller"
          return
      ), (response) ->
          event = [{'id':index++, 'available_at':availability.available_at, 'start':availability.available_at}]
          scope.event_param = event
          scope.$broadcast 'insert_success', event
          console.log 'insert error:'+response['status']
          return

  delete_available_date: ()=>
    id = @scope.id
    scope = @scope
    @http(
        method: 'DELETE'
        url: '/api/v1/availabilities/' + @scope.id
        ).then ((response) ->
          scope.id = id
          scope.$broadcast 'delete_success'
          console.log "delete success controller"
          return
      ), (response) ->
          scope.id = id
          scope.$broadcast 'delete_success'
          console.log 'delete error controller'+response['statusCode']
        return

  weekday_Click : (weekday)->
    @scope.first_available_month = first_available_month++
    switch weekday
      when 'MON' then  @scope.weekday = 1
      when 'TUE' then  @scope.weekday = 2
      when 'WED' then  @scope.weekday = 3
      when 'THU' then  @scope.weekday = 4
    @scope.$broadcast 'weekday_click' 



