# サービス名 : CAMPHOOD
![image](https://user-images.githubusercontent.com/80680556/153534150-f43ab452-c11e-46bf-9aae-feb99c804a20.png)

## URL
https://www.camphood.net/

## テストユーザーログイン
```
Email: testuser@example.com
Password: testuser
```

## サービス概要
無料キャンプ場を利用しようとしている方に向けて<br>
キャンプ場へ行くまでに欲しい情報を一目見て得られるような
情報収集の煩わしさを解消するサービス

## 登場人物
- 無料キャンプ場の利用を考えている人
- キャンプ計画をスムーズに立てたい人

## マーケット
- キャンプ初心者 ~ 中級者

## ユーザーが抱える課題
キャンプへ行く時は様々な情報を事前に集める必要がある。そもそも、無料キャンプ場では基本的に薪や備品などの買い物が出来ないため、忘れ物をした時の絶望感は尋常ではない。そのため事前の情報収集が大切になってくる。

- 目的地までの道のり、所要時間
- 食料・薪などをどこで調達するか（スーパー、ホームセンター、コンビニ)
- お風呂入りたいけど、どこにあるか
- キャンプ場周辺の天気（昼と夜の寒暖差を知りたい）
- もし体調悪くなったときに近くに病院はあるのか
- あわよくば宿泊の次の日は周辺でランチを食べて帰りたい
- そして気分が乗ったら観光も楽しみたい
とにかく充実したキャンプにするなら考えることはたくさんある。

## 機能紹介
|キャンプ場一覧画面 | キャンプ場詳細画面|
| ---            |         ---    |
| <img width="1436" alt="スクリーンショット 2022-02-11 12 44 58" src="https://user-images.githubusercontent.com/80680556/153535161-4503488c-b9e9-4eea-9ce0-d24c8479cb6c.png"> | <img width="1371" alt="スクリーンショット 2022-02-11 12 46 38" src="https://user-images.githubusercontent.com/80680556/153535193-05ea56c3-7c40-461b-a01b-fabb149e9ea4.png">|
|検索結果画面   |各キャンプ場の詳細情報。キャンプ場のレビューもこのページで行うことが可能。|

|キャンプ場周辺案内ページ① | キャンプ場周辺案内ページ②|
| ---                   |         ---          |
| ![image](https://user-images.githubusercontent.com/80680556/153536715-535ee5bd-a399-472b-a4bc-0d0ca428ab9c.png) | ![image](https://user-images.githubusercontent.com/80680556/153536831-696953ea-0665-4a3f-a7ab-7ba348d53d26.png)|
| GoogleMapとストリートビューを同時に閲覧可能。これで現在の方角を確認しながらストリートビューの操作ができる |現在地からキャンプ場までの距離と時間を算出。大体の移動時間が把握出来る。|

|キャンプ場周辺案内ページ③ |キャンプ場周辺案内ページ④|
| ---                   |         ---         |
|![image](https://user-images.githubusercontent.com/80680556/153537219-4612e1ad-c67f-4b47-aa87-7b58d0361ac8.png) |![image](https://user-images.githubusercontent.com/80680556/153537303-96cef954-1695-4608-9b1f-c70ebc1ac8f9.png)|
|キャンプ場周辺の施設を上記、ユーザーか抱える問題点を克服する内容でセレクトボックスから選択し、検索することが可能。天気予報も6時間ごと、5日間確認できるようになっている。 |おすすめのテント・アウトドア雑誌を楽天APIを用いて取得。無料キャンプ場を利用し続けるとこのテントも買えますよと言いたかった。そのために雑誌を見て物欲を高めましょうというメッセージ。|

## ER図
![image](https://user-images.githubusercontent.com/80680556/153537883-e8a16fc7-a657-4207-b47d-4420eac55d59.png)

## 画面遷移図
https://www.figma.com/file/kGUOYyP74oq5MfZVxILTlj/CampHood?node-id=0%3A1
