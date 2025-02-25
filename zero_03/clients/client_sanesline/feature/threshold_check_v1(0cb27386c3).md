## 作業名
発送元倉庫の設定

## 作業ID
554850d5ea

## branch
feature/v1.0/shipping_warehouses

## Goal
- ユーザがsku商品毎に、発送元倉庫を設定できる
- ユーザがsgu商品単位で、発送元倉庫を一括設定できる（shiftモードとでも呼ぼうかね）
- sku商品毎の、発送元倉庫の一覧を確認できる

## TODO
- ✅routes, controller
  - ✅sku商品毎の発送元倉庫の一覧画面
    - ✅GET /sku_products/shipping_warehouses
    - ✅SkuProducts::ShippingWarehousesController#index
  - ✅sku商品の発送元倉庫の設定アクション
    - ✅PATCH /sku_products/:id/shipping_warehouse
    - ✅SkuProducts::ShippingWarehousesController#update
  - ✅sgu商品の発送元倉庫の一括設定アクション
    - ✅PATCH /sgu_products/:id/shipping_warehouses
    - ✅SguProducts::ShippingWarehousesController#update
- ✅Loyalties
  - ✅config/loyalties/settings.yml
- ✅model
  - ✅SkuProduct
    - ✅shipping_warehouse_id
    - ✅belongs_to :shipping_warehouse
  - ✅Warehouse
    - ✅has_many :sku_products
- ✅view
  - app/views/sku_products/shipping_warehouses/index.html.erb
    - warehouseをセレクトボックスで表示しつつ、選択できるようにすること
      - お化粧
- ✅stimulus
  - app/javascript/controllers/sku_products/shipping-warehouses_controller.js
    - 変更した瞬間に送る
    - モード切替
- 🟡Refactor
  - ✅整理
  - ✅動的なURL生成のメソッド
  - ✅APIClient という自作モジュール
  - 🔥不要になったルーティングを消す


