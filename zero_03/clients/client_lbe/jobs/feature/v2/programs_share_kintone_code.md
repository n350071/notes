feature/v2/programs_share_kintone_code
---


複数のProgramで、同一のkintone_codeを使いたいケースがある。
---


## TODO
- Program
  - ✅kintone_codeの一意制約を外す
  - ✅検索ロジックを追加
  - ✅OriginalProgramを設定できる（相手側に送れればOK！） => original_program_id
  - ✅自己参照を持つ(migration, scope)
  - ✅画面に、自分のコピー元を表示する
  - ✅コピー元を消す処理を追加する
  - ✅もしかして、コピー元、コピー先で枠を作ったほうがいい？
- Manage::Program
  - ✅自己参照を持つProgramを持つLbeSystemは、Manage::Programを作らない（skipさせる）
- Manage::ProgramDirectCost
  - ✅自己参照を持つProgramの場合とか関係なく、Manage::ProgramDirectCostを作る
    - ✅UniqKeyが異なるので、勘定科目名としては、同じものが作られる
- ⛔️画面上で、合算した値を出すのはやらない。
- やりたいこと
  - ✅kintone_codeを表示する
  - ✅リンクを出す


