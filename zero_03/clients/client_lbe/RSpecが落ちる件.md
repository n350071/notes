時間のかかるやつ


## 失敗率
### ローカル
6/13

- 01: ✅
- 02: ✅
- 03: ❌
- 04: ✅
- 05: ✅
- 06: ❌
- 07: ✅
- 08: ✅
- 09: ✅
- 10: ❌
- 11: ❌
- 12: ❌
- 13: ❌


### CI
4/5

- 01: ❌
- 02: ❌
- 03: ✅
- 04: ❌
- 05: ✅
- 06:
- 07:
- 08:
- 09:
- 10:



## 原因
不明

## いつから？
１月の途中から

## どのコミットが原因？
[Github Actions の Failure ](https://github.com/zeroichi-hacker/lbe/actions?query=is%3Afailure) で絞りこんでを眺めていると、 [このAction](https://github.com/zeroichi-hacker/lbe/actions/runs/7332586728)
 が最初のエラー多発のようである。

ブランチとしては、[get_kintone_team_employee](https://github.com/zeroichi-hacker/lbe/commits/feature/v2.0.3/get_kintone_team_employee/) です。

プルリクエストは、 [#259](https://github.com/zeroichi-hacker/lbe/pull/259)。

コミットはどれか不明。










## エラーになるとき
失敗するとき、
let!(:xxx) { create(:program) }
のように、データを作るテストで、成功しているものもある


## エラー抜粋
```
ActiveRecord::UnknownPrimaryKey:
      Unknown primary key for table manage_clients in model Manage::Client.

ActiveRecord::RecordNotUnique:
      Mysql2::Error: Duplicate entry '0-0' for key 'programs_join_leaders.index_programs_join_leaders_on_program_id_and_leader_id'

ActiveRecord::StatementInvalid:
  Mysql2::Error: SAVEPOINT active_record_1 does not exist

NoMethodError:
  undefined method `is_super?' for nil:NilClass
```
