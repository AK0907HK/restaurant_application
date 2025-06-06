let map;
let marker;
let geocoder;

window.initMap = function () {
  const mapElement = document.getElementById('map');
  if (!mapElement) return;

  const lat = parseFloat(mapElement.dataset.lat) || 35.6803997;
  const lng = parseFloat(mapElement.dataset.lng) || 139.7690174;

  geocoder = new google.maps.Geocoder();

  map = new google.maps.Map(mapElement, {
    center: { lat: lat, lng: lng },
    zoom: 15,
  });

  marker = new google.maps.Marker({
    map: map,
    position: { lat: lat, lng: lng },
    draggable: true,
  });

  google.maps.event.addListener(marker, 'dragend', function (ev) {
    document.getElementById('lat').value = ev.latLng.lat();
    document.getElementById('lng').value = ev.latLng.lng();
  });
};

window.codeAddress = function () {
  const inputAddress = document.getElementById('address').value;

  if (!geocoder || !map) return;

  geocoder.geocode({ address: inputAddress }, function (results, status) {
    if (status === 'OK') {
      if (marker) marker.setMap(null);

      map.setCenter(results[0].geometry.location);

      marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location,
        draggable: true,
      });

      document.getElementById('lat').value = results[0].geometry.location.lat();
      document.getElementById('lng').value = results[0].geometry.location.lng();

      google.maps.event.addListener(marker, 'dragend', function (ev) {
        document.getElementById('lat').value = ev.latLng.lat();
        document.getElementById('lng').value = ev.latLng.lng();
      });
    } else {
      alert('該当する住所が見つかりませんでした: ' + status);
    }
  });
};
