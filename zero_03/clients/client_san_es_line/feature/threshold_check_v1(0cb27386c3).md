threshold_check_v1(0cb27386c3)
---

## 目標
- ハリボテのシステムを作る
  - ダッシュボード
  - CSV import画面
    - RSL
    - KOUGA
    - ...etc, 各種ボタン
  - 商品一覧画面
    - モック（商品の一覧）
    - しきい値チェックボタン (動かない)
  - （発送元拠点の変更依頼中の）商品一覧画面
    - モールの発送拠点修正画面へのリンク

## TODO
- routes, controller
  - GET /dashboard
  - GET /csv_import
  - GET /items
  - GET /items/shipment_change_request
  - ⛔️POST /items/shipment_change_request (しきい値チェックボタン)
- view
  - ダッシュボード
    - CSV import画面へのリンク
    - 商品一覧画面へのリンク
    - 発送元拠点変更依頼中商品一覧画面へのリンク
  - CSV import画面
  - 商品一覧画面
    - しきい値チェックボタン（押したら、押したよ！とだけ表示）
  - 発送元拠点変更依頼中商品一覧画面
- design
  - SKU, 商品名, ...

