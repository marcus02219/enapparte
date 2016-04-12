angular
  .module 'enapparte'
  .directive 'inputSelectAddress', ()->
    require: '^form'
    strict: 'E'
    templateUrl: 'directives/input-select-address.html'
    scope:
      model: '='
      addresses: '='
    replace: true
    transclude: true
    link: (scope, element, attrs, form)->
      scope.form = form
      scope.label = attrs.label
      scope.elementId = 'input_' + scope.$id
      scope.required = false
      scope.selectedAddress = {}

      scope.$watch 'selectedAddress', (newValue)=>
        if newValue
          angular.forEach scope.addresses, (address)=>
            address.isPrimary = false
          newValue.isPrimary = true
          if newValue.new
            $("#google-address").focus()
            $("#google-address")[0].select()
          else
            if newValue.fullAddress
              scope.model = newValue
              scope.setLocationbyAddress newValue.fullAddress

      scope.$watch 'addresses', (addresses)=>
        if addresses instanceof Array
          scope.initializeMap()
          angular.forEach addresses, (address)=>
            if address.isPrimary
              scope.selectedAddress = address
          addresses.push { fullAddress: 'Add New Address', isPrimary: false, new: true }

      scope.componentForm =
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'

      scope.initializeMap = ()->
        if !scope.map
          scope.map = new (google.maps.Map)(document.getElementById('google-maps'),
            center:
              lat: 0
              lng: 0
            zoom: 1
            navigationControl: false
            mapTypeControl: false
            scaleControl: false
            streetViewControl: false)

        input = document.getElementById('google-address')
        scope.autocomplete = new (google.maps.places.Autocomplete)(input)
        scope.autocomplete.bindTo 'bounds', scope.map
        if !scope.infowindow
          scope.infowindow = new (google.maps.InfoWindow)
        if !scope.marker
          scope.marker = new (google.maps.Marker)(
            map: scope.map
            anchorPoint: new (google.maps.Point)(0, -29))
        scope.autocomplete.addListener 'place_changed', =>
          scope.infowindow.close()
          scope.marker.setVisible false
          place = scope.autocomplete.getPlace()
          unless place.geometry
            window.alert 'Autocomplete\'s returned place contains no geometry'
            return
          # If the place has a geometry, then present it on a map.
          if place.geometry.viewport
            scope.map.fitBounds place.geometry.viewport
          else
            scope.map.setCenter place.geometry.location
            scope.map.setZoom 17
            # Why 17? Because it looks good.
          scope.marker.setPosition place.geometry.location
          scope.marker.setVisible true
          address = ''
          if place.address_components
            address = [
              place.address_components[0] and place.address_components[0].short_name or ''
              place.address_components[1] and place.address_components[1].short_name or ''
              place.address_components[2] and place.address_components[2].short_name or ''
            ].join(' ')
          scope.infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
          scope.infowindow.open scope.map, scope.marker
          # Get each component of the address from the place details
          # and fill the corresponding field on the form.
          placeInfor =
            street_number: ''
            route: ''
            locality: ''
            administrative_area_level_1: ''
            country: ''
            postal_code: ''
          i = 0
          while i < place.address_components.length
            addressType = place.address_components[i].types[0]
            if scope.componentForm[addressType]
              val = place.address_components[i][scope.componentForm[addressType]]
              placeInfor[addressType] = val
            i++
          # update address infor
          # var sel_index = $('.dashboard .form_addresses select option:selected').index().toString()
          scope.$apply =>
            scope.selectedAddress.fullAddress = $(input).val()
            scope.selectedAddress.country = placeInfor['country']
            scope.selectedAddress.state = placeInfor['administrative_area_level_1']
            scope.selectedAddress.postcode = placeInfor['postal_code']
            scope.selectedAddress.city = placeInfor['locality']
            scope.selectedAddress.street =  placeInfor['route']
            if placeInfor['street_number']
              scope.selectedAddress.street += ', ' + placeInfor['street_number']

      scope.setLocationbyAddress = (address) =>
        if !scope.map
          scope.initializeMap()
        geocoder = new (google.maps.Geocoder)
        geocoder.geocode { 'address': address }, (results, status) =>
          if status == google.maps.GeocoderStatus.OK
            scope.infowindow.close()
            scope.marker.setVisible false
            place = results[0]
            if place.geometry && place.geometry.viewport
              scope.map.fitBounds place.geometry.viewport
            else
              scope.map.setCenter place.geometry.location
              scope.map.setZoom 17
              # Why 17? Because it looks good.
            scope.marker.setPosition place.geometry.location
            scope.marker.setVisible true
            scope.infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
            scope.infowindow.open scope.map, scope.marker
          else
            alert 'Address contains no geometry ' + status
            scope.map = null
            scope.marker = null
            scope.initializeMap()
