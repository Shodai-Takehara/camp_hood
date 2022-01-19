// class = "ratings"の子要素を取得
window.addEventListener("turbolinks:load", function(){
	const stars = document.querySelector(".ratings").children;
	// id = "rating-value"の要素を取得
	const ratingValue = document.getElementById("rating-value");
	// id = "rating-value-display"の要素を取得
	const ratingValueDisplay = document.getElementById("rating-value-display");
	// indexという変数を定義
	let index;

	// reveiwの投稿ページに遷移するとstars.lengthの値（5）だけ繰り返し
	for(let i = 0; i < stars.length; i++){
		// console.log(stars.length)
		// 星にカーソルが乗ったときに実行する関数を定義
		stars[i].addEventListener("mouseover",function(){
			// stars.lengthの値（i）だけ繰り返し
			// 星カーソルが乗った時、i回繰り返される
			for(let j = 0; j < i; j++){
				// console.log(stars.length)
				// まず全て星をくり抜く
				stars[j].classList.remove("far");
				stars[j].classList.add("fa");
			}
			// そのあと星の数だけ以下の関数が繰り返される。
			for(let j = 0; j <= i; j++){
				// console.log(stars.length)
				stars[j].classList.remove("far");
				// カーソルが乗った星まで星を塗りつぶす
				stars[j].classList.add("fa");
			}
		})
		// クリックされた星の番号+1をratingValueに代入
		stars[i].addEventListener("click",function(){
			ratingValue.value = i + 1;
			ratingValueDisplay.textContent = ratingValue.value;
			// indexにクリックされた星の番号を代入
			index = i;
			// まず5回繰り返す
			for(let j = 0; j < stars.length; j++){
				// まず全ての星をくり抜く
				stars[j].classList.remove("fa");
				stars[j].classList.add("far");
			}
			for(let j = 0; j <= index; j++){
				// クリックされている星まで塗りつぶす
				stars[j].classList.remove("far");
				stars[j].classList.add("fa");
			}
		})
		// 星からカーソルが離れたときに実行される関数
		stars[i].addEventListener("mouseout",function(){
			for(let j = 0; j < stars.length; j++){
				stars[j].classList.remove("fa");
				stars[j].classList.add("far");
			}
			for(let j = 0; j <= index; j++){
				stars[j].classList.remove("far");
				stars[j].classList.add("fa");
			}
		})
	}
})
