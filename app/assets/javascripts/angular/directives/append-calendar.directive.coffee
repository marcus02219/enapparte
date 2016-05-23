angular
  .module 'enapparte'
  .directive 'appendCalendar', ['$timeout', ($timeout)->
    {
      strict: "A"
      link: (scope, $elm, attrs) ->
        $timeout ()->
          scope.$on 'weekday_click' , ()->
            date = new Date($elm.fullCalendar('getDate'))
            year = date.getFullYear()
            month = date.getMonth()
            console.log("weekday_click:" + month)
            src = []
            i = 0  
            existing_days = []
            $elm.fullCalendar 'clientEvents', (event)->
              dateE = new Date(event.available_at)
              if dateE.getFullYear() == year && dateE.getMonth() == month+1 && dateE.getDay() == scope.weekday
                existing_days.push(dateE.getDate())
            i = 1
            while i < 32
              date = new Date($elm.fullCalendar('getDate'))
              if scope.first_available_month == 0
                push_date = new Date(date.getFullYear(), date.getMonth(), i)
              else
                push_date = new Date(date.getFullYear(), date.getMonth() + 1, i)
              if push_date.getDay() == scope.weekday && i not in existing_days
                date = push_date
                date = date.toDateString()
                scope.available_at = date
                scope.insert_available_date()  
              i++
          scope.$on 'insert_success', ()->
            event_param = scope.event_param
            $elm.fullCalendar 'addEventSource',
              event_param
            $elm.fullCalendar 'refetchEvents' 
  
          scope.$on 'delete_success', ()->
            id = scope.id
            $elm.fullCalendar 'removeEvents',id

          data =  $.parseJSON attrs.data

          $elm.fullCalendar
            events: data
            dayClick: (date, jsEvent, allDay) ->
              date = new Date(date)
              date.setDate(date.getDate() + 1)
              date = date.toDateString()
              isExist = false
              remove_event = []
              toDayEvents = $elm.fullCalendar 'clientEvents', (event)->
                dateE = new Date(event.available_at)
                dateE = dateE.toDateString()
                if date == dateE
                  scope.id = event.id
                  scope.delete_available_date()     
                  $elm.fullCalendar 'removeEvents',
                    event._id
                  isExist = true
                  return
              if isExist == false
                console.log("add")
                scope.available_at = date
                scope.insert_available_date()
        , 1000
    }
  ]



