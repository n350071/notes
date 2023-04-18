# think_ac4065a67d.md
## タイトル
（リーダー登録） email address, name で csv登録・更新ができる
feature/import_leaders_with_csv

## 作業内容
- link修正
  - Leader
    - 新しいページ作成(staff list と同様)
    - ボタン作成
      - import leaders with csv


## CSVに求められる機能
- email, name を登録できる
- email が同じなら、上書きできる
- csv上のemailが既存のデータにないとき、既存データを削除しない
- 確認画面とキャンセル

## 設計
- edit
  - 「csvをインポートしてください」のリンク
- confirm
  - 「この内容で更新しますがよろしいですか？」の確認
- update
  - leadersの更新実施
  - leadersへリダイレクト

## 最小実装の手順
1. ✅update, csvを渡す、更新できる
2. ✅chatgpt を使って、csv import の型を作っておく
3. choron_form に置き換えて、csvをrailsに送信する(put update)
4. railsは、まずは、更新しちゃう
(5. 一発目を、get edit で確認画面に出す)


