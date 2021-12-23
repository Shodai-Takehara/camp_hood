document.addEventListener("turbolinks:load", window.thisMap = function() {
  // 地図を生成して表示
  const lat = gon.latitude;
  const lng = gon.longitude;
  const name = gon.campsite_name;

  let latlng = new google.maps.LatLng( lat, lng );
  let map = new google.maps.Map(document.getElementById("gmap"), {
    zoom: 14,
    center: latlng,
    mapTypeId: "roadmap"
  });
    new google.maps.Marker({
    map: map,
    position: latlng,
    title: name
  });

  let directionsService = new google.maps.DirectionsService(); // DirectionsService のオブジェクトを生成
  let directionsRenderer = new google.maps.DirectionsRenderer(); // DirectionsRenderer のオブジェクトを生成
  directionsRenderer.setMap(map); // DirectionsRenderer と地図を紐付け

  // 位置情報取得ボタンを作成
  const locationButton = document.createElement("button");
  locationButton.textContent = "現在地からキャンプ場への道のりを見る";
  locationButton.classList.add("custom-button");
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(locationButton);
  // 位置情報取得ボタンクリックで現在地取得を行い、経路探索を行う
  locationButton.addEventListener("click", () => {
    event.preventDefault();
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
        //リクエストの出発点の位置（出発地点の緯度経度）
        let start = new google.maps.LatLng(pos);
        //リクエストの終着点の位置（当該キャンプ場の緯度経度）
        let end = new google.maps.LatLng( lat, lng );

        // ルートを取得するリクエスト
        let request = {
          origin: start,      // 出発地点の緯度経度
          destination: end,   // 到着地点の緯度経度
          travelMode: 'DRIVING', //トラベルモード（車）
          drivingOptions: {
            departureTime: new Date(Date.now() + 9),  //
          }
        };

        //DirectionsService のオブジェクトのメソッド route() にリクエストを渡し、
        //コールバック関数で結果を setDirections(result) で directionsRenderer にセットして表示
        directionsService.route(request, function(result, status) {
          //ステータスがOKの場合、
          if (status == google.maps.DirectionsStatus.OK) {
            directionsRenderer.setDirections(result); //取得したルート（結果：result）をセット
            let data = result.routes[0].legs;
              for (let i = 0; i < data.length; i++) {
                let dist = data[i].distance.text; // 距離をdistへ代入
                let times = data[i].duration.text; // 時間をtimesへ代入
                document.getElementById('msg').innerHTML = "";
                document.getElementById('msg').innerHTML +=
                " 現在地からキャンプ場までは車で約 " + dist + " (" + times + ")の予定です";
              }
          } else {
            alert("取得できませんでした：" + status);
          }
        });
      },
    );
  } else {
      return false
    }
  });
})
