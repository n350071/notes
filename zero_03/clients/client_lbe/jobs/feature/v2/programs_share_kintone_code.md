feature/v2/programs_share_kintone_code
---


複数のProgramで、同一のkintone_codeを使いたいケースがある。
---


## TODO
- Program
  - ✅kintone_codeの一意制約を外す
  - 自己参照を設定できる（検索ロジックを追加）
  - 自己参照を持つ
- Manage::Program
  - 自己参照を持つProgramを持つLbeSystemは、Manage::Programを作らない（skipさせる）
- Manage::ProgramDirectCost
  - 自己参照を持つProgramの場合とか関係なく、Manage::ProgramDirectCostを作る
    - UniqKeyが異なるので、勘定科目名としては、同じものが作られる
- 画面上で、合算した値を出すのはやらない。
