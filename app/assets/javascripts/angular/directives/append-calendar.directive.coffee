angular
  .module 'enapparte'
  .directive 'appendCalendar', ['$timeout', ($timeout)->
    {
      strict: "A"
      link: (scope, $elm, attrs) ->
        $timeout ()->
          data =  $.parseJSON attrs.data
          showId = attrs.showid
          $elm.fullCalendar
            events: data
            dayClick: (date, jsEvent, allDay) ->
              date = new Date(date)
              date = date.toDateString()
              isExist = false
              toDayEvents = $elm.fullCalendar 'clientEvents', (event)->
                dateE = new Date(event.start)
                if date == dateE.toDateString()
                  return isExist = true
              date = "" if isExist
              $elm.fullCalendar 'renderEvent',
                start: date
                allDay: allDay
              $elm.fullCalendar 'rerenderEvents'
              $.ajax
                url: "/api/v1/shows/#{showId}"
                method: 'PUT'
                data: {"show":{"date_at": "#{date}"}}
                dataType: 'json'
                success: ()->

        , 1000
    }
  ]