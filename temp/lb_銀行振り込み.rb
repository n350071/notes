# 銀行へのリーダーへの支払い指示（つまり振込み）
# csv出力後は修正不可。間違いがあったときに、どこで間違えたのか？がわかるようにするため。
LeaderPayment::BankTransferCsvMetaData
- csv出力と修正不可機能（メタ情報）
  - def export_csv; end       # 振込CSVの作成. ファイル名には、time_stampを入れておく。
  - csv_export_at: DateTime   # CSV作成日, default: nil, not nil で、edit/update不可。
  - target_month: Date        # 支払い対象月
  - count_before_merged: Integer # 重複排除前の合計個数
  - total_amount_before_merged: Ineger # 重複排除前の合計金額
- csvの中身
  - row1(メタデータ)
    - row1: string             # 基本固定値のcsvデータ(振込日もそのまま入れる)
    - transfer_date: Date      # 振込日(row1に組み込まれる)
  - row2(本丸)
    - def create_transfer_data # 自分に紐づく振込データを作る
    - has_many :leader_payment_bank_transfer_rows
  - row8(checksum)
    - transfer_count: Integer  # 振込数(重複排除後のもの)
    - total_amount: Integer    # 合計金額(重複排除後のもの)
    - def count_transfer_count # 振込数を数える テストのため外だし
    - def count_total_aamount  # 合計金額を数える テストのため外だし
  - row9(空白)
    - row9: string             # 基本固定値のcsvデータ

# 手作業不可, Readonly, Salaryを修正して、再作成すること
# 主に、口座名義が間違っていることがほとんど。
# 万が一、振込額を間違えたときに、どこで間違えたのか？が、わかるようにシステム側での記録を残しておきたいので、
# CSV出力直前での、支払い額を入れておきたい。
LeaderPayment::BankTransfer
- belongs_to :leader_payments_bank_transfer_csv_meta_data
- 銀行コード
- 支店コード
- 口座種別    # default: 1 (将来2が入ってきても大丈夫にする)
- 口座番号
- 口座名義
- 振込額

# リーダーへの支払い（つまり給与） 年月を選んで自動作成・自動更新
# 基本的には、手作業での修正は不可。源泉徴収額だけ修正可能。
LeaderPayment::SalaryMonth # 給与の起点となる月
# - target_month: Date # 給与の対象月 Time.zone.parse("yyyy-mm").begining_of_day
# - has_many :salary_people
# - has_many :leader_payments_bank_transfers
# 月毎人毎の給与明細作成（含む振込額）
# ここを修正すると、銀行振り込みのデータに影響する。
LeaderPayment::Salary
- calculated_at: DateTime 計算日   # 経費と給与が分離されているよね？
- leader_id: BigInt
- total_payment: integer          # 銀行振込額
- advanced_compensation: integer  # 事前支給
- def total_salary # @return [integer] 総支給 = 総給与 + 総経費
- total_compensation: integer     # 総給与
- total_expenses: integer         # 総経費
- withholding_tax: integer                    # 源泉徴収額
- is_dependent_deduction: boolean                  # 対象月は扶養の申請を出しているか？
- is_tax_auto_caluculated: boolean # 源泉徴収額は自動計算されたか？
- def calc_tax # @return [boolean], tax が更新される
- 🤔has_many :accepted_program_expenses # 給与計算の対象になっているプログラム
- 🤔has_many :program_expenses          # 給与計算の対象月になっているプログラム
- has_many: :salary_personal_expense_relations
# 計算がズレる原因
# nowstaから連携し忘れているパターン(compensationが0)
# 留学生の経費申請をOKし忘れているパターン(accepted_program_expensesとprogram_expensesの数がズレているパターン)

# 給与計算の根拠になる経費と、個々人の給与情報の紐づけ管理モデル
LeaderPayments::SalaryPersonalExpenseRelation
- belongs_to :expense, class_name: "Programs::JoinLeaders::Expense"
- belongs_to :leader_salary, class_name: "LeaderPayment::Salary"
- validate: expense_idは重複禁止

# この考慮により、以下は不要と判断する

# これは本当に必要なのかな？？（すでに、存在するので、まとめる必要ある？） 整理しておきたくない？
# たとえば、計算がズレた！と思われたときに、どこのプログラムが「Accepted!!」になっていなくて、漏れたのか？などを
# サクッと検証できるようにしておきたい。さもないと「ズレてます」と騒がれる気がする。
# このあたりを追跡できればよいのでは？
# Program::Expense#compensation 謝礼金(Nowsta)
# Program::Expense#food_expense 経費(交通費申請)
# リーダーへの支払いに必要なデータソース
# 月毎・人毎・PG毎給与, 経費, 事前支払,扶養有無
# 振込額計算に必要なデータ収集
LeaderPayment::DataSource
- leader_id: BigInt
- target_month: Date



