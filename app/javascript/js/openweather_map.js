// "turbolinks:load"を追記することで、リロードなしで天気を表示することが可能となった
document.addEventListener("turbolinks:load", function() {
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
        "&units=metric&appid=" +
        key;

      $.ajax({
        url: openweather_url,
        dataType: "json",
        type: "GET",
      })
        .done(function (data) {
          let insertHTML = "";
          // 8の倍数でデータを取得することにより、24時間ごとの天気を取得する
          for (let i = 0; i <= 32; i = i + 8) {
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
    "(日)",
    "(月)",
    "(火)",
    "(水)",
    "(木)",
    "(金)",
    "(土)"
  );
  const date = new Date(data.list[i].dt_txt);
  date.setHours(date.getHours() + 9); // UTCとの時差を無くす(日本は-9時間のため9を足す)
  const month = date.getMonth() + 1; // getMonth()は0~11を返すため1を足すことによって1月~12月を返すように設定
  const day = month + "/" + date.getDate() + Week[date.getDay()];
  const icon = data.list[i].weather[0].icon;
  // const pop = Math.round(data.list[i].pop * 100);
  const html =
  '<div class="weather-report mx-auto">' +
    '<img src="https://openweathermap.org/img/w/' + icon + '.png">' +
    '<div class="weather-date">' + day + "</div>" +
    '<div class="weather-temp-max">' + '最高：' + Math.round(data.list[i].main.temp_max) + "℃</div>" +
    '<div class="weather-temp-min">' + '最低：' + Math.floor(data.list[i].main.temp_min) + "℃</div>" +
  '</div>';
  return html;
}
