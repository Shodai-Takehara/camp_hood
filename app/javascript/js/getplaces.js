// 位置情報を使用して周辺設備を取得
window.getPlaces = function() {
  const lat = gon.latitude;
  const lng = gon.longitude;
  const name = gon.campsite_name;

  let latlng = new google.maps.LatLng(lat, lng);

  // Mapインスタンス作成
  let map = new google.maps.Map(
    document.getElementById('gmap'),
    {
      zoom: 12,
      center: latlng,
      mapTypeId: "roadmap"
    }
  );
  new google.maps.Marker({
    map: map,
    position: latlng,
    title: name
  });
  // PlacesServiceインスタンス生成
  const service = new google.maps.places.PlacesService(map);

  // 検索範囲を取得
  let obj = document.getElementById('radiusInput');
  let radiusInput = Number(obj.options[obj.selectedIndex].value);

  // 選択したkeywordを取得
  let keywordInput = document.getElementById("keywordInput").value;

  // 周辺検索
  service.nearbySearch(
    {
      location: latlng,
      radius: radiusInput,
      keyword: keywordInput,
      language: 'ja'
    },
    displayResults
  );

  // 検索範囲の円を描く
  new google.maps.Circle(
    {
      map: map,
      center: latlng,
      radius: radiusInput,
      fillColor: '#ff0000',
      fillOpacity: 0.3,
      strokeColor: '#ff0000',
      strokeOpacity: 0.5,
      strokeWeight: 1
    }
  );
}

// エラーが解決しないため、pack側ではなくview側でクリックを検知する
// document.addEventListener('DOMContentLoaded', () => {
//   const button = document.getElementById("nearby-search")
//   button.addEventListener("click", () => { getPlaces() })
// })

function displayResults(results, status, pagination) {
  // 初期化
  document.getElementById("results").innerHTML = "検索中です...";
  placesList = new Array();

  if(status == google.maps.places.PlacesServiceStatus.OK) {

    // 検索結果をplacesList配列に連結
    placesList = placesList.concat(results);

    // pagination.hasNextPage==trueの場合、
    // 続きの検索結果あり
    if (pagination.hasNextPage) {

      // 検索結果を表示を連続実行すると取得に失敗するので、1秒くらい間隔をおく
      setTimeout(pagination.nextPage(), 1000);

    // pagination.hasNextPage==falseになったら
    // 全ての情報が取得できているので結果を表示する
    } else {

      // ratingが設定されていないものを一旦「-1」に変更する。
      for (let i = 0; i < placesList.length; i++) {
        if(placesList[i].rating == undefined){
          placesList[i].rating = -1;
        }
      }

      // ratingの降順でソート（連想配列ソート）
      placesList.sort(function(a,b){
        if(a.rating > b.rating) return -1;
        if(a.rating < b.rating) return 1;
        return 0;
      });

      //placesList配列をループして、
      //結果表示のHTMLタグを組み立てる
      let resultHTML = "<ul>";

      for (let i = 0; i < placesList.length; i++) {
        place = placesList[i];

        //評価小数点第一位まで表示
        let rating = place.rating;
        if(rating == -1) {
            rating = "---";
        } else {
            rating = rating.toFixed(1);
        };

        // 表示内容（評価＋名称＋住所）
        let content = "【評価:" + rating + "】 " + place.name + " （住所:" + place.vicinity + "） ";

      // クリック時にMapにマーカー表示するようにボタンタグを作成
      resultHTML += "<li style=\"list-style: none;\">" +
                  "<button id=\"results_button\" class=\"results_button\"" +
                  " onclick=\"createMarker(" +
                  "'" + place.name + "'," +
                  "'" + place.vicinity + "'," +
                  place.geometry.location.lat() + "," +
                  place.geometry.location.lng() + "); scrollWindow();\">" +
                  content +
                  "</button>" +
                  "</li>";
      }

      resultHTML += "</ul>";

      // 結果表示
      document.getElementById("results").innerHTML = resultHTML;
    }

  } else {
    // エラー表示
    let results = document.getElementById("results");
    if(status == google.maps.places.PlacesServiceStatus.ZERO_RESULTS) {
      results.innerHTML = "条件に該当する施設が見つかりませんでした。";
    } else if(status == google.maps.places.PlacesServiceStatus.ERROR) {
      results.innerHTML = "サーバ接続に失敗しました。";
    } else if(status == google.maps.places.PlacesServiceStatus.INVALID_REQUEST) {
      results.innerHTML = "リクエストが無効でした。";
    } else if(status == google.maps.places.PlacesServiceStatus.OVER_QUERY_LIMIT) {
      results.innerHTML = "リクエストの利用制限回数を超えました。";
    } else if(status == google.maps.places.PlacesServiceStatus.REQUEST_DENIED) {
      results.innerHTML = "サービスが使えない状態でした。";
    } else if(status == google.maps.places.PlacesServiceStatus.UNKNOWN_ERROR) {
      results.innerHTML = "原因不明のエラーが発生しました。";
    }
  }
}

window.createMarker = function(name, vicinity, lat, lng) {
  // Mapインスタンス作成
  let map = new google.maps.Map(
    document.getElementById("gmap"), {
    zoom: 14,
    center: new google.maps.LatLng(lat, lng),
    mapTypeId: "roadmap"
  });

  // マーカー表示
  let marker = new google.maps.Marker({
    map: map,
    position: new google.maps.LatLng(lat, lng)
  });

  // 情報窓の設定
  let info = "<div style=\"min-width: 100px\">";
  info += name + "<br />";
  info += vicinity + "<br />";
  info += "<a href=\"https://maps.google.co.jp/maps?q=" + encodeURIComponent(name + " " + vicinity) + "&z=15&iwloc=A\"";
  info += " target=\"_blank\">⇒詳細表示</a><br />";
  info += "<a href=\"https://www.google.com/maps/dir/?api=1&destination=" + lat + "," + lng + "\"";
  info += " target=\"_blank\">⇒現在地からの道順</a>";
  info += "</div>";

  // 情報窓の表示
  let infoWindow = new google.maps.InfoWindow({
    content: info
  });
  infoWindow.open(map, marker);

  // マーカーのクリック時にも情報窓を表示する
  marker.addListener("click", function(){
    infoWindow.open(map, marker);
  });
}
