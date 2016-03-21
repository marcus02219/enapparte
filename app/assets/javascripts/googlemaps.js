var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

var map;
var marker;
var infowindow;
var first_load = false;

function google_maps_initialize() {
  if(!map) {
    map = new google.maps.Map(document.getElementById('google-maps'), {
      center: {lat: 0, lng: 0},
      zoom: 1,
      navigationControl: false,
      mapTypeControl: false,
      scaleControl: false,
      streetViewControl: false
    });
  }

  var input = /** @type {!HTMLInputElement} */(
      document.getElementById('google-address'));

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  if(!infowindow) {
    infowindow = new google.maps.InfoWindow();
  }

  if(!marker) {
    marker = new google.maps.Marker({
      map: map,
      anchorPoint: new google.maps.Point(0, -29)
    });
  }

  autocomplete.addListener('place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Autocomplete's returned place contains no geometry");
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }

    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    var placeInfor = {
      street_number: '',
      route: '',
      locality: '',
      administrative_area_level_1: '',
      country: '',
      postal_code: ''
    };

    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
        var val = place.address_components[i][componentForm[addressType]];
        placeInfor[addressType] = val;
      }
    }

    // update address infor
    // var sel_index = $('.dashboard .form_addresses select option:selected').index().toString();
    $("#address_country").val(placeInfor["country"]);
    $("#address_state").val(placeInfor["administrative_area_level_1"]);
    $("#address_postcode").val(placeInfor["postal_code"]);
    $("#address_city").val(placeInfor["locality"]);
    $("#address_street").val(placeInfor["street_number"] + placeInfor["route"]);
  });
}

function setLocationbyAddress(sel_index)
{
  //get address by sel index
  var address;

  if($("#user_addresses_attributes_"+sel_index+"_country").val().trim() != "")
    address = $("#user_addresses_attributes_"+sel_index+"_country").val() + ", ";

  if($("#user_addresses_attributes_"+sel_index+"_state").val().trim() != "")
    address += $("#user_addresses_attributes_"+sel_index+"_state").val() + ", ";

  if($("#user_addresses_attributes_"+sel_index+"_street").val().trim() != "")
    address += $("#user_addresses_attributes_"+sel_index+"_street").val() + ", ";

  if($("#user_addresses_attributes_"+sel_index+"_city").val().trim() != "")
    address += $("#user_addresses_attributes_"+sel_index+"_city").val();

  $('#google-address').val(address);

  if(!address) {
    marker = null;
    map = null;
    initialize();
    return;
  }

  if(!map) {
    initialize();
  }

  var geocoder = new google.maps.Geocoder();

  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      infowindow.close();

      marker.setVisible(false);

      var place = results[0];
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);  // Why 17? Because it looks good.
      }

      marker.setPosition(place.geometry.location);
      marker.setVisible(true);

      infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
      infowindow.open(map, marker);

    } else {
      alert('Address contains no geometry ' + status);
      map = null;
      marker = null;
      initialize();
    }
  });
}
