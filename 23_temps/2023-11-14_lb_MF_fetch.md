# MF_fetch.md
収集開始ボタンを押すと、MFをfetchして、DirectCostにdelete_insertをかける
（データ整合性にエラーが起きるはずなので、他のモデルにはダミーを登録する）

## TODO
### その他
- ✅spec/rspec/required_spec.rb RSpecファイルが存在すること
  - ✅app/models/manage/profit_sync_agents.rb
  - ✅app/models/staff/manage.rb
### Fetch
#### ✅LbE
#### ⛔️Kintone
- ✅ kintoneの呼び出し時に、LbeSystemのことを知らなくていいようにしたい
- Lbe::Kintone::ProgramApi のリファクタリング
  - 引数はProgramではなく、Kintone_codeにする
  - get_recordはそのまま
  - parse_recordしたものを返す
- Lbe::Kintone::ProgramApi を使って、 Manage::ProfitSyncAgents::Kintone#fetch を実装する
#### ⛔️MF
- 参考
  - app/models/scheduled_tasks/sync_moneyforward_expenses.rb
#### ⛔️Google Sheet Credit
- 不明
### Merge -> Sync
- ✅MergeからSyncに変更する
- ✅Migrationを直す（子どもたちは親を見る）
- ✅各同期エージェントの呼び出し処理
### 基底
- ✅Agent
- ✅Client
- ✅Team
- ✅Employee
- ✅ProgramContributionLevel
### 追加
- ✅Program
- ✅ProgramEmployee
- ✅ProgramDirectCostから、Manage::Employee への参照を削除する
- ✅ProgramDirectCost

## 将来
- kintone_code の一意制約をつける

## migration便利コマンド
```sh
RAILS_ENV=test bin/rails db:rollback STEP=1; RAILS_ENV=test bin/rails db:migrate; bin/rails db:rollback STEP=1; bin/rails db:migrate
```

```sh
RAILS_ENV=test bin/rails db:migrate:status; bin/rails db:migrate:status
```

```sh
RAILS_ENV=test bin/rails db:migrate; bin/rails db:migrate
```

```sh
RAILS_ENV=test bin/rails db:rollback STEP=1; bin/rails db:rollback STEP=1

```

