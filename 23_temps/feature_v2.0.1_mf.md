# feature/v2.0.1/mf.md
## やること
- Lbe::MoneyForward::ExpenseApi の作成
  - 水野くんのモジュールを参考にしつつ、目的のデータを取れるか？確認
    - app/models/scheduled_tasks/sync_moneyforward_expenses.rb
  - Manage::ProfitSyncAgents::Kintone#fetch の内部実装

## 仕様
{"messages":["日付の指定期間は3ヶ月以内に抑えてください"]}
{"messages":["申請番号または日付絞り込みのための条件をいずれか指定してください"]}

## test
```rb
moneyforward = SystemSettings::Moneyforward.latest
credentials = moneyforward.to_credentials
client = Lbe::Moneyforward::Client.new(Rails.env.to_sym, credentials:)

from = 2.months.ago.beginning_of_month
to   = Time.zone.now.end_of_month

# from = Time.zone.parse('2022-08-01')
# to   = Time.zone.parse('2025-10-31')
number = nil
project_code_id = nil

# from = Time.zone.parse('2023-11-20')
# to   = Time.zone.parse('2023-11-20')
number = "19998"
# project_code_id =  "0000001"

# expenses = client.expenses(from:, to:, project_code_id:, number:)
expenses = client.expenses(from:, to:)
expenses.count
expense = expenses.first

# 0000001

# ループ処理
# expenses.first.expense_params[:number]
expenses.map { _1.expense_params[:number] }
# => [27735, 27733, 27732, 27731]

expense.expense_params.to_s.include? "0000001"

expenses.map { _1.name }.uniq

```

## TODO
### MoneyForward の APIを確認する
- ✅どのAPIを叩くと、正確にデータを取れるのか？確認する
- ✅APIの名前を決める（Lbe::Moneyforward::Client ）

### Lbe::Moneyforward::Client
- APIから取得する責務
- MoneyForwarの世界と、システムの世界の橋渡しなので、データ型の変換責務を含む
- def
  - ✅expenses
    - 直近の３ヶ月を指定するだけで、すべてをfetchする
    - kintone_codeを意識しない

### ✅Lbe::Moneyforward::Valus::Expense

### ✅Manage::ProfitSyncAgents::MoneyForward#fetch
- ✅expenses = Lbe::Moneyforward::Client.new.expenses_by_kintone_code
- ✅MoneyForwardから取得した値オブジェクトを、保存する
  - ✅migration
  - ✅❌Lbe::Moneyforward::Valus::Expenseを再現できるようになっていればよい
  - ✅📝kintone_codeがないものがあっても、保存する。あとから、kintone_codeが抜けている経費一覧を出せる。

### Domains::Manage::ProfitSyncAgents::SyncProgramDirectCost
- Manage::ProfitSyncAgents::MoneyForwardから情報を取り出して、同期する
- 参考: sync_expenses_to_manage_program_direct_costs
- 経費の検索更新 or 新規作成 by 経費Code
  - from: mf (migration)
  - 経費code (migration rename)
  - 経費申請者名
  - 経費名
