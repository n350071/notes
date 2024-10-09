Railsにおけるモデルとデータの分離されたロジックの疎結合設計について.md
---

@mizuno 【設計相談】
GPTに聞いて、納得感がなかった質問の仕方↓

## Ruby on Rails の設計について相談です。

```rb
class AiFeatures::ChatSession < ApplicationRecord
class AiFeatures::ChatSessions::Chat < ApplicationRecord
```

という既存のクラスがあります。
チャットセッションにはモードが存在します。

（例）
chat_session.mode_name #=> “teacher”

さて、
```rb
chat_session.mode #=> AiFeatures::ChatSessions::Modes::Teacher
```

というようなconstantize されたクラスが欲しいです。

ファイルは、どこに置くのが最適でしょうか？
ただし、Modes::以下には、データは存在しないため、ApplicationRecordを保持していないことがわかる場所がいいです。

- Domains::AiFeatures::ChatSessions::Modes::Base
- Domains::AiFeatures::ChatSessions::Modes::Default
- Domains::AiFeatures::ChatSessions::Modes::Gvs
というクラスを考えていた。

Modes::Base が持っていて欲しいメソッド
- AIへのモード別の指示を組み立てる
  - build_instructions(step: symbol) # @return [{role: “user”, content: “”},...]
- AIから最初の問いかけをしてもらうためのメソッド
  - build_first_chat # @return [{prompt: “defaultモードで起動します。“, assistant: “なにかお困りごとがありますか？なんでも聞いてください。“}]
- 次のステップに進んでいい？
  - judge_next_chat_step(last_chat) #=> true/false
- 次のステップに進んでいいかのワードを返すだけ
  - judegement_word_for_next_step

一方で、ActiveRecordを継承してほしいクラスは、
- AiFeatures::ChatSessions::Modes::Instruction
- AiFeatures::ChatSessions::ModeInstruction
  - key
  - title
  - description
のどちらかの辞書を入れていくだけのモデル。特にロジックはないはず。
この辞書というかモード指示書に貯まっているデータを、Modes::Gvsのロジックで、このステップなら、この指示をAIにしましょう。
…というのを動的に組み立てる設計を考えています。

ーーー
設計案２

Modeでカプセル化するのではなく、あくまでもChatSessionのDomainメソッドとして、それぞれのDomainメソッドで、ChatSession#mode_name を見て判定すればいい。

- Domains::AiFeatures::ChatSessions::Modes::BuildInstructions
- Domains::AiFeatures::ChatSessions::Modes::BuildFirstChat
- Domains::AiFeatures::ChatSessions::Modes::JudgeNextChatStep
- Domains::AiFeatures::ChatSessions::Modes::JudgementWordForNextStep

このメソッドだけ作ればいいじゃん。モードというオブジェクトは不要だよという意見。
（この場合でも、AiFeatures::ChatSessions::ModeInstruction は必要）

ーーー
設計案３
もしかしたら、そもそも、データを貯めるだけのモデル、データのないモデル、という考え方がRails的に間違っている？
→じゃあ、どうするか？という対案はない

---
## 水野の意見
### 結論
- 1.値オブジェクトして app/models/values におく
- 2.ActiveRecordと混在することを許容しmodelsにおく
のどちらかで良いかなと思います。

### 歴史
(石垣さんには歴史があるといいということだったので)
- オブジェクト指向はアラン・ケイなる人が提唱した(うちの一人)ですが、そこではオブジェクトなるものを情報の隠蔽やメッセージングが可能なものとしました。
- そんなオブジェクトの種類をパターン化するGoFデザインパターンなど、オブジェクトをパターンで整理する人たちも現れていました。
- RailsではMVCというシンプルなパターンをベースにし、いろんなデザインパターンをまとめたActiveRecordという便利なオブジェクトを生み出しました。
  - (リポジトリパターンとか全部入り。もはやアクティブレコードパターンだよね)
- Rails界隈の人たちは「業務上のモデリング」と「データベース設計」を密結合にしたんですね。
- なのでRailsしかしたことない人はモデリング=データベース設計っていう考えになってしまう人も多いようです。
- なので基本Railsをやっていると
  - 1. 業務で出てくるモデル = ActiveRecord
  - 2. 1テーブル = 1 ActiveRecord
- が前提でアプリケーションを作っていくことになります。

#### ※１
その必要はないのですが、Railsガイドとかで学んでいくとおのずとこうなってしまう
ということでRailsの慣習的には model = テーブル なんですね。
だからデフォルトでテーブルに属さないmodelの居場所がないんですよね。

#### ※２
これが昨今のDDD界隈の人たちがRailsを嫌う理由でもあるようです。
しかしシンプルなモデルの良さに気付いた人たちも多くいて、ActiveRecordじゃないモデルも扱いたいっていう人たちもたくさん出てきました。

### こっから私の考えの前提
ruby-jpとか坂口さんとかに聞いてみると以下の3パターンぐらいを私は観測しています
#### 1.テーブルに紐づく別の名前のモデルを作成する
感覚はSTIに近いですが少し違います。

例えば、以下のようにテーブルからデータを取るときに別の意味を名前として与えられたモデルを作ります。
```rb
class User < ApplicationRecord
end

class Staff < ApplicationRecord
  self.table_name = "users"
  default_scope -> { where(staff: true) }
end

class DisabledUser < ApplicationRecord
  self.table_name = "users"
  default_scope -> { where(disabled: true) }
end
```

今回の例だと、以下の感じとかですかね？
```rb
# ChatSessionの中でも、Teacherモードのものですよ！というモデル。
class AiFeatures::TeacherChatSession < ApplicationReccord
  self.table_name = "ai_features_chat_sessions"
  # 専用の処理をかいていく

  defalut_scope -> { where(mode_name: "teacher") }
end
```

(石垣補足)
使うときは、こんな感じで使うのかな？と想像。
```rb
chat_session.mode_name = "teather"
moded_chat_session = AiFeatures::TeacherChatSession.new(chat_session)
```

#### 2.libにPORO(Plain Old Ruby Object)として作成する
lib/ の下に置く

#### 3.app/models/values/ に値オブジェクトとしておく
- ※値オブジェクトはイミュータブルなオブジェクトですね
- これは設計のタイミングで値オブジェクトを使う設計にしないとだめなのでむずいです。
- 今回の例だと「モード」という値オブジェクトを考える必要があります。（もうできてそうだけど）
`app/models/values/ai_chat_mode/base/rb` ...とかで作るのもよいかもです。

### 4.ActiveRecordとか関係なくmodelsに入り乱れておく
...

### 5.modelsとは違う別レイヤーを作る
app/domain_models/ とかレイヤー作ってそこにおく。


## こっから水野の考え
### 基本的には
- choronでは3(値オブジェクト)をを基本的に採用しています。
  - 1.ActiveRecordではないことがわかるようにValuesというNamespaceからわかる
  - 2.Rails界隈の哲学？慣習？的な「1 テーブル = 1 モデル」に従える
という理由からですね。

なので3を第一候補にしています。
ただ値オブジェクトなので
- 1.イミュータブルであること
- 2.名詞的である
っていう設計が必要だと思います。
（モード、というのは名詞なのでOKですね。）

### 理想的な開発チームで行えるアラン・ケイのオブジェクト指向に立ち返った設計方針
- あとは 4(ActiveRecordとか関係なくmodelsに入り乱れておく) も別にいいのかなと最近は思ったりです。
- なんかオブジェクトのダックタイミング・ポリモーフィズムを突き詰めると、「これってActiveModel継承しているっけ？」って気にする必要ってないとおもうんですよね。
  - ※それって型優先な考えな気がする
- しかしこれはいわゆる理想論
  - (
    - オブジェクトってメッセージのやりとりができるカプセル化したものにすぎないんだぜ、
    - ぐらいでプログラムをすいすい書ける熟達度がある人ばかりの世界であるとする理想
  - )
- だと思い、実際は「これの型ってなんだろう？」を気にしたり調べながらプログラムかくことが多いだろうし、
- なんだかんだ型がわかるって大切やでなと思い。。。うーんって感じです。
  - ※このうーんが重なるほどRubyって型あるともっと便利になること多いよなと思うことがある

### まとめ
...というわけで悩んでいるので、3,4って感じです！


