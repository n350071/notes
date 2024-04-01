active_job(88ed316d85)
---

## TODO
### スパイクをつくる
- ✅ActionCableを導入する
  - ✅Connection
  - ✅Channel
  - ✅React側からのテスト
- ✅ActiveJobを継承したジョブを作る
  - ✅form.createを行う
  - ✅form.as_propsで更新内容をブロードキャストする
- ✅Controllerの変更
  - ✅ジョブを呼び出す
- ✅Reactにおいては、
  - ✅コネクション切れたときの対応

### セキュアにする
- ✅ApplicationCable::Connection で、認証を行う

### テストをちゃんとする
- ✅app/channels/application_cable/connection.rb
- ✅app/channels/ai_features_program_instructions_channel.rb
- ✅app/controllers/staff/ai_features/program_instructions_controller.rb
- 🟡app/forms/staff/ai_features/program_instructions/form.rb
  - load
  - dump
- 📌app/jobs/ai_features/program_instruction_create_job.rb

### TODO対応 ws://localhost:3000/cable でいいの？？
📌app/javascript/packs/views/staff/ai_features/program_instructions/new.tsx