stock_thresholds_setting(37a2a3c6bd)
---

## 目標
在庫のしきい値を、SKU毎 x 倉庫毎 に設定できるようにすること

## TODO
- ✅モデルの名前を設計する
- モデルを作成する
- ActiveAdminでデータを入れる
- /sku_products/stock_thresholds の画面
  - 基本
    - R::表示: データをモックから、DBデータに変更する
    - U::変更: 変更ボタンを押すと、DBのデータを更新する
    - C::作成: なし。作成時にしきい値のデフォルトを決めておく（0とか）
    - D::削除: なし。しきい値の削除はできないとする
  - UX向上
    - U::変更: フォーカスが離れただけで、DBのデータを更新する

## モデルの設計について
### 名前付け
- 代表商品
  - SguProduct
  - 説明
    - Stock Group Unit Product
    - Product: 工場などで製造されたもの製品
    - item: 数えられる商品
- 個別商品
  - SkuProduct
- 倉庫
  - Warehouse
  - 説明
    - 発送するための商品を保管したり管理する場所
    - Storage: 安全のための静的な保管庫
