# 2023-11-06_lb_charted_bus
## 依頼
```
（2023-11-02 古賀さん）
Global Leaderの支払いに関してです。1つ手当が増えました。
「新しい手当：貸切バスでの移動を伴う場合の手当」でございますが、
Chartered Bus Transportation Allowance
```

## 目的
手当が増えたので、それを入力し、計算する箱を増やしたい。

## 仕様
### 明示的
- プログラムについて、デフォルトの貸切バスでの移動を伴う場合の手当を入力できるようにする
- プログラムの各経費について、貸切バスでの移動を伴う場合の手当を入力できるようにする
### 暗黙的
- 以下に反映されること
  - 給与計算
    - 経費の合計に反映されること
      - total_expense_amount
  - kintone_csv
    -
- その他、影響範囲を調べること

## タスク
### データの追加
- ✅bin/rails g migration で、以下を追加
  - programs_join_leaders_expenses に chartered_bus
  - programs に default_chartered_bus
- ✅RAILS_ENV=test bin/rails db:migrate
### 調査
- ✅food_expenseと同様に、経費の合計に必要
### データの表示
- staff/program
### データの編集
- charted_bus
  - active_admin
- default_charted_bus
  - app/forms/staff/programs/form.rb
### データの使用
- ✅給与計算
  - total_expense_amount
- ✅kintone_csv
  - Chartered Bus Transportation Allowance:after

## migration
```
bin/rails g migration AddCharteredBus
```

## git diff --name-only develop | pbcopy
app/models/domains/manage/programs/contribution_totalize.rb
app/models/domains/manage/programs/generate_analytics.rb
app/models/domains/manage/programs/totalize.rb
app/models/domains/programs/manage_expenses_status.rb
app/models/props/manage/snapshot/program.rb
app/models/props/manage/snapshot/programs/analytic.rb

### default_chartered_bus
✅app/models/program.rb
✅app/models/domains/programs/default_expenses.rb
✅app/models/props/programs/staff.rb


### chartered_bus
food_expenseと同様に、経費の合計に必要
✅app/models/programs/join_leaders/expense.rb
✅app/models/props/programs/join_leaders/expense.rb
⛔️app/models/domains/programs/output_csv.rb
✅app/models/domains/programs/output_kintone_csv.rb


