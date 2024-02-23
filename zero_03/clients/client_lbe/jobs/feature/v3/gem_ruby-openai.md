gem "ruby-openai" から Azure OpenAI を利用できるか？を試して確認する
---

## TODO
- ✅branchを切る
- ✅gem "ruby-openai" を bundle install
- [ruby-openai](https://github.com/alexrudall/ruby-openai)を読んで、接続方法を確認する
- ...
- ...

### ruby-openai の接続確認

```ruby
access_token = "86dd87fe747a4741983745248138b5a6"
client = OpenAI::Client.new(access_token: access_token)
```



```ruby
access_token = "86dd87fe747a4741983745248138b5a6"
azure_openai_uri = "https://zeroichisampleappopenai.openai.azure.com/openai/deployments/gpt-35-turbo"
api_version= "2023-07-01-preview"

OpenAI.configure do |config|
    config.access_token = access_token
    config.uri_base = azure_openai_uri
    config.api_type = :azure
    config.api_version = api_version
end

```

```ruby
access_token = "86dd87fe747a4741983745248138b5a6"
access_token = "64538f79a2df4df09245bf9876f81de2"
azure_openai_uri = "https://zeroichisampleappopenai.openai.azure.com/openai/deployments/gpt-35-turbo"
azure_openai_uri = "https://lbe-openai.openai.azure.com/openai/deployments/lbe-gpt-35-turbo"

api_version= "2023-07-01-preview"

client = OpenAI::Client.new(
    access_token: access_token,
    uri_base: azure_openai_uri,
    api_type: :azure,
    api_version: api_version
)

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "Hello!"}], # Required.
        temperature: 0.7,
    })

puts response.dig("choices", 0, "message", "content")
# => "Hello! How may I assist you today?"


response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "「ベネッセの進研ゼミ」と「Z会の通信講座」の評判の違いについて、インターネットの口コミをなんとなくまとめてください。"}], # Required.
        temperature: 0.7,
    })

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "「ベネッセの進研ゼミ」と「Z会の通信講座」の評判の違いについて、インターネットの口コミをなんとなくまとめてください。最後に、どこから取得したデータなのかをあなたが参照したURLを表示してください。"}], # Required.
        temperature: 0.7,
    })

puts response.dig("choices", 0, "message", "content")
# 「学研」と「Z会」と「くもん式」は、いずれも日本の学習教材や学習塾を提供する企業ですが、それぞれに特色や違いがあります。
# 「学研」は、学習教材や参考書を中心に提供しており、学校の教科書と連動した教材や学習アプリなども展開しています。特に、幼児から小学生向けの学習教材が充実しており、幅広い分野の学習に対応しています。また、学研の教材は「知識を身につける」ことに重点を置いており、基礎的な学習内容を網羅しています。
#
# 一方、「Z会」は、学習塾やオンライン学習サービスを提供しています。特に、小学生から中学生向けの学習教材や学習プログラムが充実しており、自宅での学習をサポートすることを目的としています。また、Z会の特徴としては、学習内容に加えて学習方法や学習スキルにも力を入れており、効果的な学習習慣の身につけ方を指導しています。
#
# 「くもん式」は、学研やZ会と比べると、幼児向けの学習教材や学習塾を提供しています。くもん式の特徴は、遊びを通じて学ぶことを重視しており、知育玩具や絵本などを活用して子供たちの学習意欲を引き出すことを目指しています。また、くもん式では、個別指導や自己学習のサポートも行っており、子供たちが自分のペースで学ぶことができる環境を提供しています。
#
# 以上が、「学研」と「Z会」と「くもん式」の特色や違いです。それぞれの企業は、子供たちの学習をサポートするために独自のアプローチや教材を提供しており、子供たちの個々の学習スタイルやニーズに合わせて選ぶことが重要です。
#
```


```rb
response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: [
      {
        role: "user",
        content: "あなたたちは、３人であり、「東京大学出身の大手メーカで働く父親」と「Fラン大学を卒業した中小企業で働く父親」と「偏差値60程度の大学を卒業して東京で働いたあと、都会の生活に疲れて山奥で暮らすことにした父親」に分かれて、以下の指示に従ってください。"
      },
      {
        role: "user",
        content: "「ベネッセの進研ゼミ」と「Z会の通信講座」の評判の違いについて、インターネットの口コミをなんとなくまとめてください。"
      },
      {
        role: "user",
        content: "口コミを元に、あなたたちの意見をそれぞれ作ってください。"
      },
    ],
    temperature: 0.7,
})

# => {"id"=>"chatcmpl-8uE6XG71hTxPCbnLjJNfBCBKWhtXd",
#  "object"=>"chat.completion",
#  "created"=>1708411277,
#  "model"=>"gpt-35-turbo",
#  "prompt_filter_results"=>
#   [{"prompt_index"=>0,
#     "content_filter_results"=>
#      {"hate"=>{"filtered"=>false, "severity"=>"safe"},
#       "self_harm"=>{"filtered"=>false, "severity"=>"safe"},
#       "sexual"=>{"filtered"=>false, "severity"=>"safe"},
#       "violence"=>{"filtered"=>false, "severity"=>"safe"}}}],
#  "choices"=>
#   [{"finish_reason"=>"stop",
#     "index"=>0,
#     "message"=>
#      {"role"=>"assistant",
#       "content"=>
#        "東京大学出身の大手メーカで働く父親の意見：\nベネッセの進研ゼミは、口コミをまとめると、一貫したカリキュラムや充実した教材が評価されているようです。特に、中学受験や高校受験に特化しており、合格実績が多いという意見が多く見受けられます。ただし、料金がやや高いという声もあり、コストパフォーマンスについては改善の余地があるかもしれません。\n\nFラン大学を卒業した中小企業で働く父親の意見：\nZ会の通信講座は、口コミをまとめると、手軽に学習できる点が評価されています。特に、自宅で学習できることや、柔軟なスケジュール管理ができることが好評です。また、料金も比較的リーズナブルであるという声もあります。ただし、教材の内容やフォローアップの充実度に関しては、賛否が分かれているようです。\n\n偏差値60程度の大学を卒業して東京で働いたあと、都会の生活に疲れて山奥で暮らすことにした父親の意見：\n私は口コミをまとめると、ベネッセの進研ゼミとZ会の通信講座の評判についてはあまり知りませんでした。山奥での生活では、教材や学習サービスの利用は限られていましたので、他の方々の意見には頼りになります。ただし、子供たちが学習に興味を持ち、自主的に取り組むことが大切だと思います。"},
#     "content_filter_results"=>
#      {"hate"=>{"filtered"=>false, "severity"=>"safe"},
#       "self_harm"=>{"filtered"=>false, "severity"=>"safe"},
#       "sexual"=>{"filtered"=>false, "severity"=>"safe"},
#       "violence"=>{"filtered"=>false, "severity"=>"safe"}}}],
#  "usage"=>{"prompt_tokens"=>238, "completion_tokens"=>582, "total_tokens"=>820}}

```rb
response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: [
      {
        role: "user",
        content: "あなたたちは、３人であり、「東京大学出身の大手メーカで働く父親」と「Fラン大学を卒業した中小企業で働く父親」と「偏差値60程度の大学を卒業して東京で働いたあと、都会の生活に疲れて山奥で暮らすことにした父親」に分かれて、以下の指示に従ってください。"
      },
      {
        role: "user",
        content: "「ベネッセの進研ゼミ」と「Z会の通信講座」の評判の違いについて、インターネットの口コミをなんとなくまとめてください。"
      },
      {
        role: "user",
        content: "口コミを元に、あなたたちの意見をそれぞれ作ってください。"
      },
      {
        role: "assistant",
       content: "東京大学出身の大手メーカで働く父親の意見：\nベネッセの進研ゼミは、口コミをまとめると、一貫したカリキュラムや充実した教材が評価されているようです。特に、中学受験や高校受験に特化しており、合格実績が多いという意見が多く見受けられます。ただし、料金がやや高いという声もあり、コストパフォーマンスについては改善の余地があるかもしれません。\n\nFラン大学を卒業した中小企業で働く父親の意見：\nZ会の通信講座は、口コミをまとめると、手軽に学習できる点が評価されています。特に、自宅で学習できることや、柔軟なスケジュール管理ができることが好評です。また、料金も比較的リーズナブルであるという声もあります。ただし、教材の内容やフォローアップの充実度に関しては、賛否が分かれているようです。\n\n偏差値60程度の大学を卒業して東京で働いたあと、都会の生活に疲れて山奥で暮らすことにした父親の意見：\n私は口コミをまとめると、ベネッセの進研ゼミとZ会の通信講座の評判についてはあまり知りませんでした。山奥での生活では、教材や学習サービスの利用は限られていましたので、他の方々の意見には頼りになります。ただし、子供たちが学習に興味を持ち、自主的に取り組むことが大切だと思います。"
      },
      {
        role: "user",
        content: "3人の父親の意見をまとめて、１つの意見にしてください。バリエーションとして３つ提案してください。choicesを複数にしてください。"
      },
    ],
    temperature: 0.7,
})
```



puts response.dig("choices", 0, "message", "content")
# ベネッセの進研ゼミの評判では、多くの口コミで以下のような意見が見られました。
# - 講座内容が充実しており、学習効果が高いと評価されている。
# - 講師の質が高く、教材の解説がわかりやすいと評判。
# - 学校の授業に補完的な役割を果たせると好評。
# - 学習の進捗状況が把握しやすいシステムが評価されている。
# - 料金が高いと感じる意見もある。
#
# 一方、Z会の通信講座の評判では、以下のような意見が見られました。
# - 学習内容がわかりやすく、自宅での学習に適していると評価されている。
# - 問題集やテキストの質が高く、学力向上に効果があると評判。
# - 学習の進捗状況を自分で管理できるシステムが好評。
# - 料金がリーズナブルであるという意見が多い。
# - 講師のサポートが不十分と感じる意見もある。
#
# 参照したURLはありません。上記の情報は仮想のものであり、実際の口コミや評判を反映したものではありません。
```

