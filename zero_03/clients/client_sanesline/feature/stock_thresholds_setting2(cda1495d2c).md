stock_thresholds_setting(37a2a3c6bd)
---

## 目標
在庫のしきい値を、SKU毎 x 倉庫毎 に設定できるようにすること

## TODO
- ✅Controllerを修正する
- ✅個別に修正できるようにする
  - ✅[ActualStockのid, しきい値]で、しきい値を設定する(update) (RSpecを書いておく)
  - ✅フォーカスが離れただけで、DBのデータを更新する
- ⛔️まとめて修正できるようにする
  - ActualStocks::StockThresholdsController
    - [ids, しきい値]で、しきい値を設定する(update_bulk)


## 実装メモ
input data-xxxx, bindしているタグの内容をとってくればいいじゃん
alert/modal/tooltip/toast で更新しました！










