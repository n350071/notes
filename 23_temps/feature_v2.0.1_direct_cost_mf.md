# feature/v2.0.1/direct_cost_mf.md
## やること
MFから取得したデータの細目もDirectCostに反映させる(ページ、税抜き等)
- Fetch
  - ✅MFのページ対応
  - 📌その他の情報の保存
  - 📌税抜き価格の計算と保存（migration）
- DirectCost
  - 🔥費用の二重計上問題が発生しないように、一意制約をつける（特定のサービスに依存しない制約: [service, code] の組み合わせ）
- SyncDirectCost
  - 📌MFその他の項目
  - 🔥LBその他の項目
  - 📌User#mf_member_id で、MFの従業員を特定できるようにする(migration)


## MFのページ対応
2023-09-01
2023-11-30

17page( 16 * 50 + 1~50 = 800~850件)

"next":"/api/external/v1/offices/J4t2gsevoIFChzioLajXeA/ex_transactions?office_id=J4t2gsevoIFChzioLajXeA\u0026page=17\u0026query_object%5Brecognized_at_from%5D=2023-09-01\u0026query_object%5Brecognized_at_to%5D=2023-11-30"


## MF実験
```rb
moneyforward = SystemSettings::Moneyforward.latest
credentials = moneyforward.to_credentials
client = Lbe::Moneyforward::Client.new(Rails.env.to_sym, credentials:)

from = Time.zone.parse('2023-10-29')
to = Time.zone.parse('2023-10-29')
expenses = client.expenses(from:, to:)

```