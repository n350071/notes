active_job(88ed316d85)
---

## TODO
### スパイクをつくる
- ✅ActionCableを導入する
  - ✅Connection
  - ✅Channel
  - ✅React側からのテスト
- ActiveJobを継承したジョブを作る
  - 実装内容は、3秒待ってから、ブロードキャストすること
- Controllerの変更
  - form.create をコメントアウトする
  - ジョブを呼び出す
  - レスポンスとして、サブスクライブすべきチャンネルを返す
- Reactにおいては、
  - レスポンスを受け取って、サブスクライブを開始する
  - サブスクライブで、メッセージを受け取ったら、アラート表示する
  - コネクション切れたときの対応

### セキュアにする
- ApplicationCable::Connection で、認証を行う

### ActiveJobで非同期処理を実施（ローカルのみ）
- ActiveJobを継承したジョブを作成する
- ジョブのテストを書く
- コントローラーにて、 form.create をジョブ呼び出しに変更する（および、その影響）
  - 即時返事
    - 返答は、即時の返事に変更する
    - ジョブの終了時に、返答を行う
  - 非同期返事
    - ActionCableを導入して、非同期の返事を行う
### Delayed Job を導入して、本番環境でも、非同期処理を実施
- gem install
  - gem 'delayed_job_active_record'
  - gem 'daemons'
- 本番起動時の設定
  - up-production
  - up-production-quick




gem 'delayed_job_active_record'
gem 'daemons'


bin/rails generate delayed_job:active_record
bin/rails db:migrate

## ジョブの作成
```ruby
class UserCreationJob < ApplicationJob
  queue_as :default

  def perform(form)
    if form.create
      # 成功時の処理。しかし、非同期のため直接レスポンスを返すことはできません。
    else
      # 失敗時の処理。同上。
    end
  end
end
```

## ジョブの呼び出し
```ruby
class UsersController < ApplicationController
  def create
    form = build_form
    UserCreationJob.perform_later(form)
    # ジョブをキューに入れたことをユーザーに通知します。
    render json: { message: 'Your request is being processed. Please wait.' }
  end
end
```