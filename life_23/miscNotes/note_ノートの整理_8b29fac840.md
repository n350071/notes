note_ノートの整理_8b29fac840
---


## 要求事項
- 全文検索が可能であること
- 管理しやすいこと（１つのリポジトリで管理できること）
- トピックに集中できること
- 階層が少ないこと
- １つのノートが１００行程度で小さいこと
- 削除容易性
- アーカイブ容易性

## kpt
-
  - ✅k: 23, 23pj などのprefixはわかりやすい
  - ✅k: 階層が１つしかないことで、ノートが階層内で迷子にならない
  - ✅k: _で始まるパーシャルノートの存在で、分離できる
  - ✅p: 家庭と仕事の分離ができていない
  - ✅p: 23pjのノートが多すぎて、わからない
  - ✅p: フォルダ構造が変わってしまうと、リンクが切れてしまう
  - ✅t: ファイルの末尾に、ハッシュ値をつけて、それでリンクとする（全文検索で１意に絞れる）
  - ✅t: カテゴリprefixを作る
  - ✅p: プロジェクトが乱立している
  - ✅t: 同一階層内で、記事が１０個を超えたら、フォルダ化する。フォルダも同一prefixが10個を超えたら親子にする
  - ✅t: prefixのリファクタリングも、頻繁に行う
  - ✅p: ゼロイチハッカーと家庭では周期が違う
  - ✅p: プロジェクトの連番は意味がないし、リファクタリングの邪魔になる
  - ~~p: ゴミ記事がフォルダの内部に残ってしまう~~
  - ✅p: 思考整理の散文メモ、知識を伝える知見ノート、その中間の状況把握ノートが混在している
  - ✅t: ノートそのものに、レベルprefixをつける
  - ✅t: ノートそのものには、カテゴリprefixをつけない
  - ✅k: ファイル名で検索できる（今後も、 23 仕事 ruby とかで検索できる仕組みなので、そのままkeep）
  - ✅t: sha コマンドを作成し、これを貼ることで、リンクとする（１兆パターンのハッシュ値があるので、全文検索で１意に絞れるでしょう）
  - ✅p: 日々の統合されたタスク管理と、プロジェクトのタスク管理を統合的に見れない
  - ✅t: planノートの中に、jobへのリンクをつけておく

## フォルダのprefixの検討
- life_yy
  - plan
    - plan_yyyy_mm.md
- work_yy
- zero_yy

## ノートのレベルprefixの検討
- draft_ ドラフト
- note_ ノート
- _ パーシャルノート
- job_ 実務的な職務管理ノート
- alias_ 別記事へのリンクしかないノート

## ノートの命名規約
- *_secret_* は、秘密情報を含み、gitignoreされる

