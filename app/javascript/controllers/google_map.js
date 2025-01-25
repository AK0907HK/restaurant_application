document.addEventListener('turbo:load', () => {
  if (document.getElementById('map')) {
    initMap();
  }
});

let map;
let marker;
let geocoder;

function initMap() {
  geocoder = new google.maps.Geocoder();
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 35.6803997, lng: 139.7690174 },
    zoom: 15,
  });
}

function codeAddress() {
  const inputAddress = document.getElementById('address').value;

  geocoder.geocode({ address: inputAddress }, function (results, status) {
    if (status === "OK") {
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
      alert("該当する住所が見つかりませんでした: " + status);
    }
  });
}
