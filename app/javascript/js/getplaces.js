// 位置情報を使用して周辺設備を取得
function getPlaces() {
  const lat = gon.latitude;
  const lng = gon.longitude;
  const location = new google.maps.LatLng(lat, lng);

  // 初期化
  document.getElementById('results').innerHTML = "";
  placesList = new Array();

  // Mapインスタンス作成
  const map = new google.maps.Map(
    document.getElementById('googlemap'),
    {
      zoom: 13,
      center: location
    }
  );

  // 検索範囲を取得
  const obj = document.getElementById('radiusInput');
  const radiusInput = Number(obj.options[obj.selectedIndex].value);

  // PlacesServiceインスタンス生成
  const place = new google.maps.places.PlacesService(map);

  // 周辺検索
  service.nearbySearch(
    {
      location: location,
      radius: radiusInput,
      keyword: '',
      language: 'ja'
    },
    displayResults
  );

  // 検索範囲の円を描く
  const circle = new google.maps.Circle(
    {
      map: map,
      center: location,
      radius: radiusInput,
      fillColor: '#ff0000',
      fillOpacity: 0.3,
      strokeColor: '#ff0000',
      strokeOpacity: 0.5,
      strokeWeight: 1
    }
  );
}
document.addEventListener('DOMContentLoaded', () => {
  const button = document.getElementById("nearby-search")
  if (!button){ return false;}
  button.addEventListener("click", () => { getPlaces() })
})

function displayResults(results, status, pagination) {
  if(status == google.maps.PlacesServiceStatus.OK) {
    // 検索結果をplacesList配列に連結
    placesList = placesList.concat(results);

    // pagination.nextPageで次の検索結果を表示する
    if (pagination.hasNextPage) {
      setTimeout(pagination.nextPage(), 1500);
    } else {
    }
  }
}
