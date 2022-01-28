// アバター画像アップロードの非同期更新
window.previewImage = function () {
  const target = this.event.target;
  const file = target.files[0];
  const reader = new FileReader();
  reader.onloadend = function () {
    const preview = document.querySelector("#preview");
    if (preview) {
      preview.src = reader.result;
    }
  };
  if (file) {
    reader.readAsDataURL(file);
  }
};

// ヘッダーのデザイン
window.addEventListener("scroll", function () {
  // ヘッダーを変数の中に格納する
  const header = document.querySelector("header");
  // 20px以上スクロールしたらヘッダーに「scroll-nav」クラスをつける
  header.classList.toggle("scroll-nav", window.scrollY > 20);
});

// フラッシュメッセージのフェードアウト
$(function () {
  setTimeout("$('#flash').fadeOut('slow')", 3000);
});

// guidanceページ検索結果画面ボタンクリック後にMapまで移動する
window.scrollWindow = function () {
  window.scrollTo({
    top: 60,
    left: 0,
    behavior: 'smooth'
  });
}
