// streetviewを表示
window.streetView = function() {
  const lat = gon.latitude;
  const lng = gon.longitude;
  const address = gon.address;
  let latlng = new google.maps.LatLng(lat, lng);
  let obj = document.getElementById("panorama");
  obj.id = "pano";

  // Mapインスタンス作成
  let map = new google.maps.Map(
    document.getElementById('gmap'),
    {
      zoom: 15,
      center: latlng,
    }
  );
  let contentString = '住所：' + address;
  let infowindow = new google.maps.InfoWindow({
    content: contentString
  });

  let marker = new google.maps.Marker({
    position: latlng,
    map: map,
    title: contentString,
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });

  let panorama = new google.maps.StreetViewPanorama(
    document.getElementById("pano"),
    {
      position: latlng,
      pov: {
        heading: 70,
        pitch: 0,
      },
    }
  );
  map.setStreetView(panorama, marker);
}
