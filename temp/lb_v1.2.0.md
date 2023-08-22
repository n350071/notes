# lb_銀行振込CSVの絵コンテ0.md
## 絵コンテ方針
- 全体を貫くUX(Stories)を明確にする（キャンバスのサイズを確認する）
- UXを最小限に実現する

## 軽い設計
temp/lb_銀行振り込み.rb

## 全体を貫くStories
- 経理は、 対象月の給与情報を作成できる(new create show index)
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報を自動生成できる(caluculate_leader_salaries)
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報を確認できる(index show)
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報のうち、源泉徴収額を手修正できる（edit, update）
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報を一覧して、怪しいものがあることに気づける, アラート機能
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報を自動更新できる(caluculate_leader_salaries)
- 経理は、 給与情報を元に、対象月の銀行振込依頼データを作成できる(new create show), 銀行振込依頼データRowも作成される
- 経理は、 複数の銀行振込依頼データから、対象月の銀行振込依頼データを選択できる(index, show)
- 経理は、 銀行振込依頼データのRowデータを確認し、マージされたことや怪しいものがあることに気づける(index)
- 経理は、 銀行への振込依頼データのメタ情報を修正できる(edit, update)
- 経理は、 銀行への振込依頼データからCSVを出力できる(export_csv)
- 経理は、 出力済みの振込依頼データを確認できるが、修正はできない(index, show)
- 経理は、 給与情報を元に、対象月の銀行振込依頼データを再作成できる。ただし、未出力のものがない場合に限られる。

## 最小限のStories
- 経理は、 対象月の給与情報を作成できる(new create show index)
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報を自動生成できる(caluculate_leader_salaries index)
- 経理は、 給与情報を元に、対象月の銀行振込依頼データを作成できる(new create show), 銀行振込依頼データRowも作成される
- 経理は、 銀行への振込依頼データからCSVを出力できる(export_csv)

## tasks_01: ハリボテ
- 経理は、 対象月の給与情報を作成できる
  - Staff::LeaderPayments::SalariesController
    - ✅index
      - 給与情報の一覧画面
    - ⛔️new
      - 給与情報の新規作成
    - ⛔️create
      - 給与情報の新規作成
    - ✅show
      - 作成したものを確認
- 経理は、 対象月の給与情報に紐づく、リーダーの給与情報を自動生成できる(caluculate_leader_salaries index)
  - Staff::LeaderPayments::SalariesController
    - ⛔️caluculate_leader_salaries
  - Staff::LeaderPayments::Salaries::LeaderSalariesController
    - ❌index (給与情報詳細画面にて、給与一覧の表示もしているので、不要かも)
- 経理は、 給与情報を元に、対象月の銀行振込依頼データを作成できる(new create show), 銀行振込依頼データRowも作成される
  - Staff::LeaderPayments::BankTransfersController
    - ✅index
      - ターゲット給与に紐づくもの一覧
    - ⛔️new
      - どの年月の給与データか？によって、自動で対象月を決める, メタ情報の入力
    - ⛔️create
      - 同時に、銀行振込依頼データRowも作成する
    - ✅show
      - 作成したものを確認
  - Staff::BankTransfers::RowsController
    - ❌index（不要かも）
- 経理は、 銀行への振込依頼データからCSVを出力できる(export_csv)
  - ✅Staff::LeaderPayments::BankTransfers::ExportCsvController
    - show
      - csvを出力する





