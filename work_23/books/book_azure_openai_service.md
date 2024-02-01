book_azure_openai_service
---

## memo01
Azure OpenAi を使うと
- 企業規模の大小に関わらず、セキュリティと信頼性を担保した形で、OpenAIを使える
- 自社向けのカスタマイズができる
- 社内データの漏洩を最小限にできる

## memo02
カスタマイズについては、以下が必要
- Azure OpenAI
- 周辺サービス
- 社内のデータベース
- 各種システム

## memo03
自然文の検索は「Azure AI Search」

## memo04
フレームワークは「LangChain」と「Semantic Kernel」

## memo05
「プロンプトフロー」を使うと、Web UI で組み立てれられるらしい

## memo06: もくじ解釈
### 解釈
1〜3は、さらっと読む
5-1を読んだあと、
どのツール・技術を使うかを検討して、それを読んでから、
4を読んで、実践しよう

### 要約されたもくじ
- ✅1: Azure OpenAI
  - オリエンテーション
- ✅2: ChatGPTの基礎知識
  - 歴史
  - 生成AI概要
  - ChatGPT概要
  - プロンプト・プロンプトエンジニアリング
- ✅3: Azure OpenAI を使う理由
  - Azure OpneAI のポジション
  - メリット（デメリットの目次はない）
  - 責任あるAI（なんだそれ？）
- 4: Azure OpenAI の環境構築（ここから本番）
  - 利用方法
  - Studio
  - デプロイ
  - プレイグラウンド
  - オープンソースモデルのデプロイ
- 5: Azure OpenAI に関するツールや技術
  - アーキテクチャ全体像（ここは押さえておきたい、4より先に読もう）
  - Copilot Stack（かっこいい）
  - Azure AI Search
  - Grounding/RAG
  - On your data
  - LangChain
  - Semantic Kernel
  - Function Calling
  - プロンプトフロー
  - プラグイン開発
  - ファインチューニング
  - Azure AI Content Safety（なんとなくセキュリティっぽいので、ここは先に読みたい）

なんでセキュリティ最後なの..???

## memo07: Azure OpenAI とは的な
- 生成AIシステムを開発する場合
  - Azure OpenAI
  - Azure Machine Learning
  - Copilotシステム
  - ..などを活用することで、開発スピードを上げられる
- 本書では、周辺サービスも含めて「Azure OpenAI」と呼ぶ
- 魔法のように感じる要素
  - 精度
  - スピード
- AIに指示するプロンプトが重要
  - 生成AIは、受け身、指示待ち
  - 人と話すのと同じように、背景や具体例を伝える必要がある
  - まるで知人のように会話したいなら、予めこちらの情報を伝えておく必要がある
- OpenAIのMission == 汎用型人工知能（AGI）
  - これまでは、特化型人工知能
  - 特化型を集約したのが汎用型
- AGIの定義「一般的に人より賢いAIシステム」
- AGIのvision「新たな知識の創造」
  - 人は一生をかけて１つの専門を極める
  - AGIは、複数の専門を横断的に思考できるから、関係なさそうな知識同士を組み合わせた知識を錬成する
    - （ちょうどマイルスデイビスが、休日にフラメンコを観て、それをジャズに取り入れて進化させたような感じなのだろうね）
    - （そういう使い方を意識しておくと良さそうね）
- AIが導くと、様々な問題が起こると考えられている
  - （手塚治虫の火の鳥、AIが核戦争を起こす話を思い出した）
  - AIは人を支えるものになるように制御する必要がある
  - これは開発者もユーザも認識しておくことが重要
- MetaのGalacticaが失敗した理由と対策
  - 差別
    - RLHF(Reinforcement Learning From Human Feadback)学習法
  - 誤答
    - ハルシネーション（幻覚）、嘘つき
    - GPTは単語予測器

## memo08: マイクロソフトとの相乗効果
- 拡張性、セキュリティ、SLA、責任あるAI
- 単に生成AIを導入するだけでは、ビジネスに貢献しない
- LLM単体では、限界がある
- 独自データの追加・外部データの参照
- インサイトを得るためには、適切な追加開発が必要

## memo09: インサイトを得る copilot stack
- 1: Azure OpenAI (LLM)
- 2: + 独自データ (Grounding / RAG)参考書がプロンプトの手前にくるっぽい
- 3: + 外部アプリ/データ （プラグイン (ReAct)） LLMが不得なことは別のツールで解決
- 4: + ファインチューニング/OSS （OSS: MetaのLLMなど） LLM再学習（コスト、時間が結構かかるが、トークン数減、精度向上、スピード向上）

## memo10: 学習から逸れる話
- 哲学的ゾンビ
  - AGIはすごいけれど、単語予測器を発展させると、思考になるのだろうか？
- 理解なき思考
  - そもそも言語を扱っているのか？普遍文法の立場からすると、人は世界を理解するほうが先にあって、言葉は後付ではないか？
    - [古舘伊知郎×成田悠輔](https://youtu.be/sAHTifR_eto?si=1MgqtxAvDpz0hWSX)
    - 「色のない緑の概念が、猛然と眠る」
    - 人間が世界を捉えるのではなく、自然が人間に入ってくる
    - 音楽の歌詞は、絶妙に意味が通っていないからこそ、人の心に届く
  - 「感受性をもって、理解する」ということができないのではないか？
  - 「言葉で割り切れないこと」が、わからないのではないか？
  - 「言葉から滑り落ちたもの」が、わからないのではないか？

## memo11: 代表的な４つのユースケース
- セキュリティを担保した社内用ChatGPT
- 自然言語を使った社内情報の検索サービス
  - 根拠資料も提示してくれる
  - レポートなどのテンプレートを渡しておいて、成果物の作成依頼もできる
- コールセンター向けなどの業務特化の支援サービス（チャットボットに専門性をもたせる）
  - 営業資料の作成
  - 感情分析
  - 監査
- ユーザの代わりにタスクを代行してくれるコンシェルジュサービス

## memo12: DXがベース
- 再利用可能なデータの量が大事
- RPAの下敷きがあれば、AIに連携しやすい
- AI単体で語ると、その能力を活かしきれない

## memo13: 生成AIとは
- 入力（自然言語）
- エンコーダー
- ベクトル
- モデル
- 出力（自然言語）

## memo14
AIの学習モデルは、主に２つ
- 生成モデル: 与えられたデータと、学習したパターンに基づいて、出力を生成する確率モデルを使用
- 識別モデル: 訓練データから学習したモデルを基に、与えられたデータを検知・分類するモデル
  - 分類問題
  - 回帰問題

## memo15 識別モデル
P(Y | X)
与えられたXから、クラスYを識別する。
アルゴリズム
- k-最近傍
- ロジスティック回帰
- サポートベクターマシン
- 決定木
- ...
（大学で学んだやつに近いものがある）

## memo16 生成モデル
事後確率=(事前確率x尤度)/限界確率
学習データから事前確率、尤度を推定
尤度は、関数によって表現
尤度P(X|Y)を使ってクラスYに属するサンプルを生成するので、生成モデルと呼ばれる。

犬か猫かのクラスに属するサンプルを生成する、つまり、サンプルとは、その特徴なので、犬っぽい話をしているのであれば、犬の分類元となる特徴、つまり、耳とか尻尾とか、そういうものを生成する。
（...という文章は、GitHub Copilotと協力して作ったので、納得感がある）

## memo17
|特徴 | 識別モデル | 生成モデル |
| --- | --- | --- |
| アプローチ | データの決定境界 | データを生成する確率分布 |
| 学習目標 | 各クラスの条件付き確率を最大化 | データの生成確率を最大化 |
| 計算量 | 比較的少ない | 多い |
| 学習の種類 | 教師あり | 教師なし |
| 使用例 | 画像分類、テキスト分類 | 画像生成、テキスト生成 |

## memo18: 生成AIの種類とユースケース
- text-to-text
- text-to-code
- text-to-image
- image-to-image
- text-to-video
- text-to-3D
- text-to-music
- text-to-speech
- speech-to-speech

## memo19: 注意
- 再学習しない設定
  - 制限がある
  - 制限の内容は変わる可能性がある
- 注意
  - プライバシー・機密情報は、再学習されるおそれがあるため、入力しないこと
    - Azure OpenAI Service を使う理由
  - ハルシネーション（幻覚）／嘘がある
    - 人がファクトチェックをする
    - 厳格性と創造性の設定をする
      - Azure OpenAI Service を使う理由
  - 回答は同じにならない
  - 一度の会話記憶には限度がある
    - トークンの削除順序を指定する
      - Azure OpenAI Service を使う理由
  - 最新情報や機密情報は学習されていない
    - Azure OpenAI Service を使う理由
  - 近接誤差の影響で、最後に入力した内容に強い影響を受ける可能性がある
    - 最後に、もう一度、命令を繰り返すことで精度を高められる
  - 計算など苦手な処理がある
    - Azure OpenAI Service を使う理由
  - 政治問題や倫理問題は回答が制御されている

## memo20
プロンプトエンジニアリングは、ChatGPTを利用するためのテクニックではない。
実際には、生成AIシステム開発においても、不可欠の知識。
人間同士の会話と同様に、生成AIシステムにも、会話の流れをコントロールするためのテクニックが必要。

## memo21: 初歩的なプロンプトエンジニアリング
- 区切り文字による指示と文脈の分離
- 具体的に指示を出す・説明する・詳細を記載する
- 曖昧な指示や不正確な指示を減らす
- 「実行してほしくないこと」ではなく「実行してほしいこと」を指示する
  - あることを禁止しても、それ以外の探索範囲が広すぎて、効果が薄い

## memo22: メタプロンプト
- システム側で文脈や出力形式などのメタプロンプトを添えること
- システムメッセージ、システムプロンプト、とも呼ばれる
- 代表的なメタプロンプト
  - ペルソナ
  - 文脈
  - 出力形式
  - 入力データ
- 生成AIシステムでは、特にメタプロンプトの工夫が重要で、回答の品質に直結する
  - 4.4.2, 5.4.6を参照
- メタプロンプトを、プロンプトの前に設定すること

## memo23: その他のプロンプトエンジニアリング
- Few-shot learning
  - （過去の実例を学習させるとかも、これに入りそう）
- Chain of Thought
  - 実験だと、 few-shot learning よりも精度が高い。

## memo23: 前提条件確認プロンプト
- 指示: 〜を教えてください
- 前提: そのための前提条件として、知っておくべきことがあれば、聞いてください
- 実行: CoTが働いて、前提条件を確認したうえで、実行してくれる

## memo24: RCI(Recursively Criticizes and Improves)
評価・修正をLLM自身に繰り返させる方法
- 指示: [x]を書いてください
- RCI: その後、以下手順を３回繰り返して、[x]をブラッシュアップしてください
  - 1: 評価
  - 2: 評価を反映した[x]を記載

## memo25: 遺伝的アルゴリズム
- 指示
- 以下の条件で遺伝的アルゴリズムを適用してください
  - 評価関数: (自然言語で記載)
  - 評価結果: 必ず記載すること
  - 個体数: 5
  - 最終世代: 3
- RCIと違って、選択・交叉・突然変異があり、進化させる。評価関数がある。

## memo26: ブレインストーミング
- 以下のメンバーで、ブレインストーミングを行ってください
  - メンバー
    - A: (ペルソナを記載)
    - B: (ペルソナを記載)
    - C: (ペルソナを記載)
- 指示: (ブレインストーミングのテーマを記載)
- RCIや遺伝的アルゴリズムと組み合わせてもOK

## memo27: とりあえずGAFAMの生成AIにしておけ
- 長年の研究
- 独自の技術と特許
- サポートとメンテナンス
- エンタープライズ向けソリューション
- コンテンツフィルタリング
- SLA
- セキュリティ
- AIの責任

## memo28: 各社のサービス
詳細は、p. 72
- Google
- Apple
- Meta
- Amazon: Bedrock, CodeWhisperer, ChatGPTのようなものを構築するのに必要なツールを提供
- Microsoft
- IBM
- Oracle
- Salesforce
- Adobe
- SAP

## memo29: Azure OpenAI Service の概要
- 📌Azure Service Fabric:
  - 説明: スケーラブルで信頼性のあるマイクロサービスとコンテナをパッケージ化、デプロイ、管理するための分散システムプラットフォームです。
  - URL: [Azure Service Fabric Overview](https://learn.microsoft.com/en-us/azure/service-fabric/service-fabric-overview)
  - Equivalent in AWS: Amazon ECS, Amazon EKS
- Azure App Service:
  - 説明: Webアプリケーション、REST API、モバイルバックエンドをホストするHTTPベースのサービスで、複数のプログラミング言語に対応し、自動スケーリングや高可用性を提供します。
  - URL: [Azure App Service Overview](https://learn.microsoft.com/en-us/azure/app-service/overview)
  - Equivalent in AWS: AWS Elastic Beanstalk, AWS Amplify
- 📌Azure Database Service:
  - 説明: セキュアでエンタープライズグレードの、完全管理型データベースサービスを提供し、急速な成長をサポートし、より早くイノベーションを実現します。
  - URL: [Azure Databases](https://azure.microsoft.com/en-us/products/category/databases/)
  - Equivalent in AWS: Amazon RDS, Amazon DynamoDB
- 📌Azure AI Service:
  - 説明: 機械学習、認識サービス、会話AIなどを含む、AI開発のための包括的なサービス群です。
  - Equivalent in AWS: Amazon AI Services
- Azure Security Compliance:
  - 説明: セキュリティ管理とコンプライアンス監査を簡素化するツールとサービスを提供します。
  - Equivalent in AWS: AWS Security, Identity, & Compliance
- Azure Functions:
  - 説明: イベントに応答してコードを実行するサーバーレスコンピューティングサービスです。
  - Equivalent in AWS: AWS Lambda
- Azure Hybrid Solution:
  - 説明: オンプレミスとクラウド環境の間で一貫したアプリケーション開発と管理を可能にするソリューション群です。
  - Equivalent in AWS: AWS Outposts, Amazon VPC

## memo30: Azure AI Service
- Azure Machine Learning
- Azure AI Search
- 📌Azure OpenAI Service
- ...etc

## memo31: Azure OpenAI
- モデルをデプロイする
  - GPTシリーズ
  - Codex
  - Embeddings
  - DALL-E
- Azure OpenAI Studio
  - webツール
  - モデルのデプロイに使用
  - LLMのパラメータを設定（ハイパーパラメータ）
  - コンテンツフィルター
  - ファインチューンング
- 構成
  - 以下を組み合わせる
  - Azure OpenAI でデプロイしたLLM
  - Azure AI Service のなにか

## memo32: Azure OpenAI の特徴
- モデルの種類: 省略
- 価格: 従量課金
- ネットワーク環境: 仮想 & プライベート エンドポイント接続
- マネージドID: Microsoft Entra ID経由
- UI:
  - モデル: Azure OpenAI Studio
  - アカウント: Azure Portal
- リージョン: 利用可能なモデルが異なる
- コンテンツフィルター: プロンプトと回答の両方に対して、有害かどうか調べてブロックできる
- API: REST API ( though Azure OpenAI Studio )
- 認証方式: APIキー, Microsoft Entra ID
- データ保持: 悪用/監視目的で30日間保持
- データ保持: 保持されないように要求可能
- プライバシー: Microsoftの声明と製品ポリシーに準拠、日本の法律を準拠法
- モデルのリリース: OpenAIの後追い

## memo33: OpenAI と Azure OpenAI の違い
- OpenAI
  - ChatGPTなど
  - SLAなし
- Azure OpenAI
  - LLMモデルが異なる
  - OpenAIの技術を独自に統合
  - 学習に利用されない

（つまり、オブジェクトに閉じ込めたから、それらを組み合わせて使ってね、というノリなのでしょう）

## memo34: Azure OpenAIで提供可能な機能と注意
- 機能
  - スマートな会話
  - 文章の要約
  - 文章の作成
  - 感情分析
- 注意
  - コスト（利用状況によっては、想定以上のコストがかかることがある）
  - 情報の正確性

## memo35: 責任あるAI
- ロボット三原則
  - ロボットは人間に危害を加えてはならない。
  - ロボットは人間による命令に服従しなければならない。ただし、ある命令が第一条に反する場合は、この限りではない
  - ロボットは自己を守らなければならない。ただし、第一条および第二条に反する場合は、この限りではない。
- RAFT
  - 責任あるAIを支えるフレームワーク
  - R: Reliable 信頼性
    - ライフサイクル全体にわたって、一貫性と信頼性を持ち、安全であること
  - A: Accountable 説明責任
    - 組織内で説明可能で、適切に管理されていること
  - F: Fair 公平性
    - 公平であり、差別的な結果を生み出さないこと
  - T: Transparent 透明性
    - 透明であり、その動作や決定過程が理解可能であること
- Azure OpenAIの責任あるAIの原則
  - 企業が利用する場合の懸念、RAFT違反について
    - R: AIが不適切な内容を生成し、予期しない行動を取る可能性
    - A: 個人情報を適切に扱わない可能性
    - F: 特定の集団について偏った結果を出す可能性
    - T: 意思決定過程が不透明であるため、その結果を信頼することが難しい場合があり、ハルシネーションへの対応が必要
  - Azure Open AI の原則
    - R: 信頼でき、安全であるべき
    - R: プライバシーを尊重し、セキュリティを確保するべき
    - F: AIはすべての人々に公平であるべき
    - T: 行動と結果がどのように決定されたかを明らかにして、AIの意思決定過程を理解しやすくするべき
  - Microsoftの表明
    - ユーザのデータは、ユーザのもの
    - ユーザのデータは、AIモデルの学習に利用されない
    - ユーザのデータとAIモデルはすべての段階で保護される
- 責任あるAI構築のための、Microsoftのフレームワーク
  - Responsible AI Standard 第二版
    - https://news.microsoft.com/ja-jp/2022/07/04/220704-microsofts-framework-for-building-ai-systems-responsibly/
    - https://blogs.microsoft.com/wp-content/uploads/prod/sites/5/2022/06/Microsoft-Responsible-AI-Standard-v2-General-Requirements-3.pdf
- 詳細
  - Fairness, Relibility & Safety, Privacy & Security & Inclusiveness
  - Tranparency
  - Acountability
- 仕組み
  - Governance
  - Rules
  - Training & Practice
  - Tools & Processes
    - （基本的には、ここを使うのでしょうが、上を知っておくと、概念理解が早そうだね）
- 「責任あるAI」を実現するサービス
  - Azure OpenAI Studio
    - コンテンツフィルター機能
      - LLMに対して、入出力の安全性を手軽にチェックできる機能
  - Azure Ai Content Safety
    - オープンソースのものを含む任意のLLMと画像生成AIモデルを対象としたより汎用性が高い機能
- MetaのGalacticaが失敗した理由
- 生成物の著作権侵害に対する保証について
  - Copilot Copyright Commitment
    - マイクロソフトは法的視つくに対処する責任を負う
      - 条件があるっぽい
  - Azure OpenAI は、2023年12月から適用
  - これから判例が積み上がっていくので、自社の法務部門と相談すること

## memo36: 前半のまとめ
- memo09: インサイトを得る copilot stack: 生成AIシステムにも段階がある
- memo12: DXがベース: 生成AIシステムを活かすには、データが重要であるから、前段階としてRoRシステムが必要になる
- memo20~memo26: プロンプトエンジニアリングは、生成AIシステム開発にも必要である
- memo28: 各社のサービス: うまく組み合わせて使うことで、初心者をサポートするプログラミング環境を作ることができそう
- memo35: 責任あるAI: 意外と大事だった。ここを無視すると、人間にとっては、使い物にならないAIになるので、ここはしっかりと押さえておきたい

## memo37: Azure OpenAI アーキテクチャ全体像
