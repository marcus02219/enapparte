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

  componentForm:
    street_number: 'short_name',
    route: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'short_name',
    country: 'long_name',
    postal_code: 'short_name'

  init: =>
    @User
      .get(1)
      .then (user)=>
        @scope.user = user
        @scope.initializeMap()

    @scope.$watch 'user.address', (newValue)=>
      if newValue && newValue.fullAddress
        @scope.setLocationbyAddress newValue.fullAddress

  userSave: =>
    if @scope.user
      @scope.user.save()
        .then (user)=>
          @scope.user = user
          @Flash.showNotice @scope, 'User was saved successfully.'
        , (error)->
          console.log error
          # @Flash.showError @scope, 'User was saved successfully.'

  initializeMap: =>
    if !@scope.map
      @scope.map = new (google.maps.Map)(document.getElementById('google-maps'),
        center:
          lat: 0
          lng: 0
        zoom: 1
        navigationControl: false
        mapTypeControl: false
        scaleControl: false
        streetViewControl: false)

    input = document.getElementById('google-address')
    @scope.autocomplete = new (google.maps.places.Autocomplete)(input)
    @scope.autocomplete.bindTo 'bounds', @scope.map
    if !@scope.infowindow
      @scope.infowindow = new (google.maps.InfoWindow)
    if !@scope.marker
      @scope.marker = new (google.maps.Marker)(
        map: @scope.map
        anchorPoint: new (google.maps.Point)(0, -29))
    @scope.autocomplete.addListener 'place_changed', =>
      @scope.infowindow.close()
      @scope.marker.setVisible false
      place = @scope.autocomplete.getPlace()
      unless place.geometry
        window.alert 'Autocomplete\'s returned place contains no geometry'
        return
      # If the place has a geometry, then present it on a map.
      if place.geometry.viewport
        @scope.map.fitBounds place.geometry.viewport
      else
        @scope.map.setCenter place.geometry.location
        @scope.map.setZoom 17
        # Why 17? Because it looks good.
      @scope.marker.setPosition place.geometry.location
      @scope.marker.setVisible true
      address = ''
      if place.address_components
        address = [
          place.address_components[0] and place.address_components[0].short_name or ''
          place.address_components[1] and place.address_components[1].short_name or ''
          place.address_components[2] and place.address_components[2].short_name or ''
        ].join(' ')
      @scope.infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
      @scope.infowindow.open @scope.map, @scope.marker
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
        if @scope.componentForm[addressType]
          val = place.address_components[i][@scope.componentForm[addressType]]
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
    if !@scope.map
      @scope.initializeMap()
    geocoder = new (google.maps.Geocoder)
    geocoder.geocode { 'address': address }, (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        @scope.infowindow.close()
        @scope.marker.setVisible false
        place = results[0]
        if place.geometry && place.geometry.viewport
          @scope.map.fitBounds place.geometry.viewport
        else
          @scope.map.setCenter place.geometry.location
          @scope.map.setZoom 17
          # Why 17? Because it looks good.
        @scope.marker.setPosition place.geometry.location
        @scope.marker.setVisible true
        @scope.infowindow.setContent '<div><strong>' + place.name + '</strong><br>' + address
        @scope.infowindow.open @scope.map, @scope.marker
      else
        alert 'Address contains no geometry ' + status
        @scope.map = null
        @scope.marker = null
        @scope.initializeMap()
