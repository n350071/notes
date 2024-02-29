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

### commit
https://github.com/zeroichi-hacker/lbe/pull/259/commits/7551d719072ddc17b9f050ab6b17b1745567b813

### spec files
spec/models/manage/program_employee_spec.rb
spec/models/values/manage/analytics/program_spec.rb

(上記の２テストをコメントアウトしても、特に変わらず)


## その他
- bundle exec rspec だとエラーが起きない？






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

## 失敗するテストを、30回繰り返しで実行する
```rb
# spec/models/props/leader_payments/bank_transfers/traceability_spec.rb

    # 1000 examples, 0 failures
    1000.times do |i|
      puts "try #{i}"
      it "キャメルケースのJSON値が取得できること" do
        aggregate_failures do
          expect(subject[:id]).to eq 100
          expect(subject[:bankNumber]).to eq "0001"
          expect(subject[:branchNumber]).to eq "001"
          # 省略
        end
      end
    end

```


## bisectオプションで失敗する組み合わせを特定する
```sh
bin/rspec --seed 65100 --bisect=verbose
bin/rspec --seed 1003 --bisect=verbose --format=documentation
bin/rspec --seed 1003 --bisect --format=documentation
```


## エラーを一部特定
以下のファイルで、500回繰り返すと、必ず１回はエラーが発生する。
エラーが発生しても、次のテストは成功することがある。
エラーが発生したときに、前後のテストが失敗することがある。

bin/rspec --seed 65100 spec/forms/staff/nowsta/compensations/form_spec.rb

```rb
    context "ファイルが渡されているとき" do
      # 本テストは以下のCSVと密結合です。変更する際はご注意ください
      let!(:file) { SpecFileUpload.set("spec/files/csvs/nowsta/valid.csv", "text/plain", true) }
      let!(:params) { { file: file } }
      context "該当するデータが存在しないとき" do
        500.times do |i|
          it "falseが返り、エラーメッセージが設定されていること" do
            expect(form.import).to eq false

            error_messages = form.error_messages
            expect(error_messages.size).to eq 3
            expect(error_messages).to include "The combination of Kintone Program ID: 101 and email address: ishigaki@example.com was not found in system."
            expect(error_messages).to include "The combination of Kintone Program ID: 102 and email address: mizuno@example.com was not found in system."
            expect(error_messages).to include "The combination of Kintone Program ID: 103 and email address: foo@example.com was not found in system."
          end
        end
      end
```


## 減ったエラー
### 1
bin/rspec
spec/forms/leader/programs/expenses/form_spec.rb
spec/models/props/leader_payments/target_terms/staff_spec.rb
spec/models/props/manage/snapshot/employee_spec.rb
spec/models/props/ai_features/program_instruction_spec.rb
spec/models/manage/profit_sync_agents/lbe_system_spec.rb
spec/requests/staff/expenses/accepted_statuses_controller_spec.rb
spec/models/domains/programs/output_kintone_csv_spec.rb
spec/models/user_spec.rb
spec/requests/devises/leaders/passwords_controller_spec.rb
spec/requests/staff/leader_payments/bank_transfer_csv_meta_infos_controller_spec.rb
spec/models/programs/join_leaders/expense_spec.rb
spec/requests/staff/programs/expenses_statuses_controller_spec.rb
spec/models/domains/manage/profit_sync_agents/money_forward_expenses/fetch_spec.rb
spec/models/master/system_setting_spec.rb
spec/requests/current/mypages_controller_spec.rb
spec/requests/leader/externals/programs/expenses_controller_spec.rb
spec/models/props/manage/program_direct_cost_spec.rb
spec/models/image_spec.rb
spec/models/domains/leader_payments/salaries/separate_expenses_spec.rb
spec/models/manage/snapshot/program_employee_spec.rb

### 2
1503 examples, 22 failures, 40 pending

Failed examples:

rspec ./spec/models/programs/join_leader_spec.rb
rspec ./spec/models/manage/team_spec.rb
rspec ./spec/models/props/programs/staff_spec.rb
rspec ./spec/models/manage/snapshot/agent_spec.rb
rspec ./spec/requests/staff/leader_payments/target_terms/payslips_controller_spec.rb
rspec ./spec/models/scheduled_tasks/run_profit_sync_agent_spec.rb
rspec ./spec/models/props/programs/join_leaders/expenses/with_transport_spec.rb
rspec ./spec/models/props/manage/snapshot/employee_spec.rb
rspec ./spec/models/leader_payments/salary_expense_relation_spec.rb
rspec ./spec/models/domains/leader_payments/target_terms/create_bank_transfers_spec.rb
rspec ./spec/mailers/leader_mailer_spec.rb
rspec ./spec/models/domains/manage/profit_sync_agents/sync_program_direct_cost_credit_spec.rb
rspec ./spec/models/domains/leader_payments/salaries/combine_expenses_spec.rb
rspec ./spec/models/leader_payments/bank_info_spec.rb
rspec ./spec/models/props/manage/snapshot/client_spec.rb
rspec ./spec/models/domains/leader_payments/salaries/separate_expenses_spec.rb
rspec ./spec/models/manage/snapshot/program_employee_spec.rb



## Randomized with seed 11007 のとき
1503 examples, 3 failures, 40 pending

Failed examples:

rspec ./spec/forms/leader/programs/expenses/form_spec.rb:153 # Leader::Externals::Programs::Expenses::Form#update (異常系) (経費の状態がAcceptedになっているとき) エラーになり、申請が承認済なのが分かるエラーメッセージが取得できること
rspec ./spec/forms/leader/programs/expenses/form_spec.rb:126 # Leader::Externals::Programs::Expenses::Form#update (異常系) (申請済みの経費(order: 1)のはずだが、idが存在しない) エラーになること
rspec ./spec/models/domains/leader_payments/salaries/separate_expenses_spec.rb:77 # Domains::LeaderPayments::Salaries::SeparateExpenses#call 統合した経費データを分離したHashが取得できること

Randomized with seed 11007


✅ bin/rspec --seed 11007 spec/forms/leader/programs/expenses/form_spec.rb spec/models/domains/leader_payments/salaries/separate_expenses_spec.rb

❌ bin/rspec --seed 11007
1503 examples, 2 failures, 40 pending
- spec/services/leaders/visa_info_update_notification_service_spec.rb
- spec/models/domains/leader_payments/salaries/separate_expenses_spec.rb