# feature/v2.0.1/kintone_earnings.md
# TODO
### Lbe::Kintone::ProgramApi
- ✅APIから取得する責務
- ✅kintoneの世界と、システムの世界の橋渡しなので、データ型の変換責務を含む
- ✅TODO
  - recordの内容を、Values::Kintone::Program に詰め込んで、値オブジェクトを返す

### Values::Kintone::Program
- ✅システムで扱いやすくしたkintoneの案件情報

### Manage::ProfitSyncAgents::Kintone#fetch
- ✅Kintoneから取得した値オブジェクトを、保存する
  - #earnings
  - ⛔️#client
  - ⛔️#agent
  - ⛔️#employees_with_team

### Domains::Manage::ProfitSyncAgents::SyncProgram
- ✅_program.earnings = kintone.earnings
