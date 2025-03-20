document.addEventListener('turbo:load', () => {
    // 地図要素が存在する場合に初期化
    const mapElement = document.getElementById('map');
    if (mapElement) {
      const lat = parseFloat(mapElement.dataset.lat) || 35.6803997; // 緯度 (デフォルト: 東京駅)
      const lng = parseFloat(mapElement.dataset.lng) || 139.7690174; // 経度 (デフォルト: 東京駅)
      
      // Google Maps API がロードされている場合のみ初期化
      if (typeof google !== 'undefined' && typeof google.maps !== 'undefined') {
        initMap(lat, lng);
      }
    }
  });
  
  let map;
  let marker;
  let geocoder;
  
  // initMap を定義
  function initMap(lat, lng) {
    geocoder = new google.maps.Geocoder();
  
    // 地図の初期化
    map = new google.maps.Map(document.getElementById('map'), {
      center: { lat: lat, lng: lng },
      zoom: 15,
    });
  
    // マーカーの設定
    marker = new google.maps.Marker({
      map: map,
      position: { lat: lat, lng: lng },
      draggable: true, // ドラッグ可能
    });
  
    // マーカーをドラッグしたときのイベント
    google.maps.event.addListener(marker, 'dragend', function (ev) {
      document.getElementById('lat').value = ev.latLng.lat();
      document.getElementById('lng').value = ev.latLng.lng();
    });
  }
  
  // codeAddress を定義
  window.codeAddress = function () {
    const inputAddress = document.getElementById('address').value;
  
    geocoder.geocode({ address: inputAddress }, function (results, status) {
      if (status === 'OK') {
        // マーカーが既に存在する場合は削除
        if (marker) marker.setMap(null);
  
        // 地図の中心を設定
        map.setCenter(results[0].geometry.location);
  
        // 新しいマーカーを作成
        marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          draggable: true,
        });
  
        // 緯度と経度を DOM に設定
        document.getElementById('lat').value = results[0].geometry.location.lat();
        document.getElementById('lng').value = results[0].geometry.location.lng();
  
        // ドラッグイベントを再設定
        google.maps.event.addListener(marker, 'dragend', function (ev) {
          document.getElementById('lat').value = ev.latLng.lat();
          document.getElementById('lng').value = ev.latLng.lng();
        });
      } else {
        alert('該当する住所が見つかりませんでした: ' + status);
      }
    });
  };