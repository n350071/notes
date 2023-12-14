# feature/v2.0.1/direct_cost_mf.md
## やること
MFから取得したデータの細目もDirectCostに反映させる(ページ、税抜き等)
- Fetch
  - ✅MFのページ対応
  - 📌その他の情報の保存
  - 📌税抜き価格の計算と保存（migration）
- DirectCost
  - ✅費用の二重計上問題が発生しないように、一意制約をつける（特定のサービスに依存しない制約: [service, code] の組み合わせ）
- SyncDirectCost
  - 📌MFその他の項目
  - 🔥LBその他の項目
  - 📌User#mf_member_id で、MFの従業員を特定できるようにする(migration)


## DirectCostUniq
- migration
  - data_source
  - data_id