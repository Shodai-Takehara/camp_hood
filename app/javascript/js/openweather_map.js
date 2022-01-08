// "turbolinks:load"を追記することで、リロードなしで天気を表示することが可能となった
document.addEventListener("turbolinks:load", window.openWeather = function() {
  if (typeof gon !== "undefined") {
    const key = gon.openweather_map_key;
    const lat = gon.latitude;
    const lng = gon.longitude;

    if (typeof key !== "undefined") {
      // APIリクエストurl作成(「5dayweatherforecast」を利用）
      const openweather_url =
        "https://api.openweathermap.org/data/2.5/forecast?lat=" +
        lat +
        "&lon=" +
        lng +
        "&units=metric&lang=ja&appid=" +
        key;

      $.ajax({
        url: openweather_url,
        dataType: "json",
        type: "GET",
      })
        .done(function (data) {
          let insertHTML = "";
          // 8の倍数でデータを取得することにより、24時間ごとの天気を取得する
          for (let i = 0; i <= 32; i += 2) {
            insertHTML += buildHTML(data, i);
          }
          $("#openweather").html(insertHTML);
        })
        .fail(function (data) {
          alert("天気予報取得に失敗しました");
        });
    }
  }
});

// 日本語化 最高気温は四捨五入、最低気温は切り捨て
function buildHTML(data, i) {
  const Week = new Array(
    "(<span style='color: red;'>日</span>)",
    "(月)",
    "(火)",
    "(水)",
    "(木)",
    "(金)",
    "(<span style='color: blue;'>土</span>)"
  );
  const strDate = data.list[i].dt_txt;
  const date = new Date(strDate.replace(/-/g, "/")); // iOSでNanと表示されるため、yyyy-mm-dd -> yyyy/mm/ddへ変換する
  date.setHours(date.getHours() + 9); // UTCとの時差を無くす(日本は-9時間のため9を足す)
  const month = date.getMonth() + 1; // getMonth()は0~11を返すため1を足すことによって1月~12月を返すように設定
  const day = month + "/" + date.getDate() + Week[date.getDay()];
  const time = date.getHours();
  const description = data.list[i].weather[0].description;
  const icon = data.list[i].weather[0].icon.slice(0, -1) + 'd'; // 夜の太陽マークが分かりにくため、末尾のn(night)を削除し、d(datetime)を追加して太陽マークを表示する
  // const pop = Math.round(data.list[i].pop * 100);
  const html =
  '<div class="weather-report">' +
    '<img src="https://openweathermap.org/img/w/' + icon + '.png">' +
    '<div class="weather-description mb-2">' + description + "</div>" +
    '<div class="weather-date mb-2">' + day + "</div>" +
    '<div class="weather-time mb-2">' + time + " : 00" + "</div>" +
    '<div class="weather-font">' + '<span class="weather-temp-max">最高：</span>' + Math.round(data.list[i].main.temp_max) + "℃</div>" +
    '<div class="weather-font">' + '<span class="weather-temp-min">最低：</span>' + Math.floor(data.list[i].main.temp_min) + "℃</div>" +
  '</div>';
  return html;
}
