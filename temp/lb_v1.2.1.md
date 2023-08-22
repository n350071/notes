# lb_銀行振込CSVの絵コンテ1.md
## tasks_01: ハリボテ（まとめ）
- 経理は、 対象月の給与情報を作成できる(Staff::LeaderPayments::SalariesController#index, show)
- 経理は、 給与情報を元に、対象月の銀行振込依頼データを作成できる(Staff::LeaderPayments::BankTransfersController#index, show)
- 経理は、 銀行への振込依頼データからCSVを出力できる(Staff::LeaderPayments::BankTransfers::ExportCsvController#show)

## ルール
後回しにするときのコメント
```rb
# TODO_bank_csv:
```

## バージョン
- ✅ver1.2.1.0: TargetTerms
- ✅ver1.2.1.1: 給与計算と給与一覧
- ✅ver1.2.1.2: BankTransfer
- ✅ver1.2.1.3: LinkToExpense
- 🔥ver1.2.1.4: CleanUP

## tasks_02: リスクあるところから肉付け
### 絵コンテからUXの修正部分（ハリボテ修正）
- ✅経理は、 対象期間を一覧し、作成できる (ver0.2.0: TargetTerms)
  - ✅Staff::LeaderPayments::TargetTermsController
    - ✅index
    - ✅new
    - ✅create
  - ✅LeaderPayments::TargetTerm
- ✅給与の自動計算と一覧画面 (ver0.2.1: 給与計算と給与一覧)
  - ✅経理は、対象期間の給与を自動計算できる
    - ✅Staff::LeaderPayments::TargetTerms::CalcSalariesController
      - ✅create (post指示)
      - ❌update （再計算指示）
  - ✅経理は、対象期間の給与を確認できる
    - ✅Staff::LeaderPayments::TargetTerms::SalariesController
      - ✅index
  - ✅給与自動計算のロジック
    - ✅LeaderPayments::TargetTerm#create_salaries
    - ✅元になるExpenseとの関連付け（どの支払いが元になっているか？を把握できるの準備）
    - ⛔️LeaderPayments::Salary に、エラーログを残す仕組みを入れて、間違いに気づける仕組みを構築する
- ✅振込データの自動計算と一覧画面 (ver0.2.2: BankTransfer)
  - ✅経理は、対象期間の振込データを確認できる
    - ✅Staff::LeaderPayments::TargetTerms::BankTransfersController
      - ✅index
      - ✅tsx
  - ✅経理は、対象期間の振込データを自動生成できる
    - ✅Staff::LeaderPayments::TargetTerms::CalcBankTransfersController
      - ✅create
        - ✅BankTransferを作る
        - ✅Metaデータも作る
      - ❌update （再計算指示）
- ✅経理は、どの振込データが、どの給与が元になっているか？把握できるし、さらにExpenseへのリンクおよび、表がある (ver1.2.1.3: LinkToExpense)
  - Staff::LeaderPayments::TargetTerms::SalariesController#
    - show
- ⛔️経理は、対象期間のCSVメタデータを確認・修正できる
  - Staff::LeaderPayments::TargetTerms::BankTransferCsvMetaInfosController
    - show
    - edit
    - update
- ⛔️経理は、対象期間の振込データをCsv出力できる
  - Staff::LeaderPayments::TargetTerms::BankTransferExportCsvsController
    - show
- ⛔️経理は、完了した振込について、完了チェックを入力したり外したりができる
  - Staff::LeaderPayments::TargetTerms::BankTransfers::CompletesController
    - update
  - Staff::LeaderPayments::TargetTerms::BankTransfers::BulkCompletesController
    - update
- 🔥不要なゴミを片付け(ver1.2.1.4: CleanUP)

### 実データで正常系のみ実現する（一部ハリボテ可）
- ⛔️銀行口座インポート（LeaderPayments::LeaderInfo）: ハリボテ
- ✅対象期間の新規作成（LeaderPayments::TargetTerm）
- ✅リーダーの給与情報の自動計算（LeaderPayments::Salary, LeaderPayments::SalaryExpenseRelation）
  - ✅給与計算ロジック
  - 源泉徴収ロジック
    - 保存されたSalaryを元に、源泉徴収額を計算し、振込額を更新するメソッド
- ✅銀行振込データ
  - ✅給与合計額と銀行振込データを合体させて、一覧およびメタデータを作成するメソッド
- ✅トレーサビリティ
- ⛔️完了チェック（on, off）: タイムスタンプと作業者の記録がつく
- ⛔️CSV出力
  - 銀行振込データを元に、CSVを作成し、出力する

### （トレーサビリティ）経理は、どの振込データが、どの給与が元になっているか？を把握したい(ver1.2.1.3: LinkToExpense)の分解
#### 状況と理由を想定
- ✅👑この振込金額は、どの経費申請が根拠になっているのか？を辿りたい, because 金額が怪しいときのために。
- ⛔️👑振込金額の合計額が妥当っぽいことを、Nowstaとの連携で合計額との突き合わせで確認したい, becuase 検算のため
  - なにかのIDの一覧を、csv形式でコピーできると良さそう？
- ⛔️✨この振込金額は、たしかに、この給与の振込額の総額であるとわかりたい, because 金額をひとめでチェックするため
- ⛔️👍この振込金額は、たしかに、この給与の振込額の総額であり、それらは、これらの経費申請の総額だとわかるようにしたい, because 金額をひとめでチェックするため

#### ストーリー
- ✅対象期間から「妥当性チェック」画面に移動できる
- ⛔️「妥当性チェック画面」では、表示項目が絞られていて、以下の構造になっている, IDコピーもできる
  - ✅構造
    - 振込データ
      - has_many 給与
        - has_many 経費申請（謝礼金含む）
  - ✅表示項目
    - ✅振込のID
    - ✅"#{銀行コード} #{支店番号} #{口座番号} #{口座名義}"
    - ✅振込金額 = SUM(給与の支払額)
    - ✅給与のID
    - ✅給与に紐づくリーダーの名前
    - ✅給与の支払額（total_payment） = SUM(経費申請の謝礼) + SUM(経費申請の立替分) - 給与の控除額（源泉徴収） - 給与の控除額（事前支払い）
    - ✅給与の控除額（源泉徴収）
    - ✅給与の控除額（事前支払い） = SUM(経費申請の事前支払い)
    - ✅経費申請に紐づくプログラムの名前
    - ✅経費申請のID
    - ✅経費申請の謝礼（compensation:total）
    - ✅経費申請の立替分（total_expsense）
    - ✅経費申請の事前支払い（advanced_payment）
  - ⛔️プログラムのIDの羅列？（役に立つか判らないのでモック）
