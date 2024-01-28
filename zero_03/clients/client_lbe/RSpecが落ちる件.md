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
