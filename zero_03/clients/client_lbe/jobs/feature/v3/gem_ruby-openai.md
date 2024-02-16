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
azure_openai_uri = "https://zeroichisampleappopenai.openai.azure.com/openai/deployments/gpt-35-turbo"
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


