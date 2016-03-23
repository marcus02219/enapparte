class ProfileController extends @NGController
  @register window.App, 'ProfileController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'User'
  ]

  user: {}
  map: null

  init: =>
    if @rootScope.currentUser
      @User
        .get @rootScope.currentUser.id
        .then (user)=>
          @scope.user = user
          @scope.initializeMap()

    @scope.$watch 'user.address', (newValue)=>
      if newValue
        @scope.setLocationbyAddress newValue.fullAddress

  initializeMap: =>
    if !@scope.map
      map = new (google.maps.Map)(document.getElementById('google-maps'),
        center:
          lat: 0
          lng: 0
        zoom: 1
        navigationControl: false
        mapTypeControl: false
        scaleControl: false
        streetViewControl: false)

    input = document.getElementById('google-address')
    autocomplete = new (google.maps.places.Autocomplete)(input)
    autocomplete.bindTo 'bounds', map
    if !infowindow
      infowindow = new (google.maps.InfoWindow)
    if !marker
      marker = new (google.maps.Marker)(
        map: map
        anchorPoint: new (google.maps.Point)(0, -29))
    autocomplete.addListener 'place_changed', ->
      infowindow.close()
      marker.setVisible false
      place = autocomplete.getPlace()
      if !place.geometry
        window.alert 'Autocomplete\'s returned place contains no geometry'
        return
      # If the place has a geometry, then present it on a map.
      if place.geometry.viewport
        map.fitBounds place.geometry.viewport
      else
        map.setCenter place.geometry.location
        map.setZoom 17
        # Why 17? Because it looks good.
      marker.setPosition place.geometry.location
      marker.setVisible true
      address = ''
      if place.address_components
        address = [
          place.address_components[0] and place.address_components[0].short_name or ''
          place.address_components[1] and place.address_components[1].short_name or ''
          place.address_components[2] and place.address_components[2].short_name or ''
        ].join(' ')
      infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
      infowindow.open map, marker
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
        if componentForm[addressType]
          val = place.address_components[i][componentForm[addressType]]
          placeInfor[addressType] = val
        i++
      # update address infor
      # var sel_index = $('.dashboard .form_addresses select option:selected').index().toString();
      $('#address_country').val placeInfor['country']
      $('#address_state').val placeInfor['administrative_area_level_1']
      $('#address_postcode').val placeInfor['postal_code']
      $('#address_city').val placeInfor['locality']
      $('#address_street').val placeInfor['street_number'] + placeInfor['route']

  setLocationbyAddress: (address) =>
    if !map
      @scope.initializeMap()
    geocoder = new (google.maps.Geocoder)
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        infowindow.close()
        marker.setVisible false
        place = results[0]
        if place.geometry.viewport
          map.fitBounds place.geometry.viewport
        else
          map.setCenter place.geometry.location
          map.setZoom 17
          # Why 17? Because it looks good.
        marker.setPosition place.geometry.location
        marker.setVisible true
        infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
        infowindow.open map, marker
      else
        alert 'Address contains no geometry ' + status
        map = null
        marker = null
        initializeMap()
