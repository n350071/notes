money_forward_api_error(a06f16d0a1)

---

## エラーメッセージ
"MoneyForward API Error: "

### 推定
- response.ok? ではなかった
- response.response.body にエラーメッセージが入っていない
- response.responseはnilではない
- レポートなのか明細なのか、どちらで起きたのかわからない

```rb
class Lbe::Moneyforward::Private::ExReportsClient
  # 省略
  def index
    # クエリは実際には、office_id, page しかないので、使用していません。
    response = api_client.ex_reports(queries: [])

    unless response.ok?
      raise Error, "MoneyForward API Error: #{response.response.body}"
    end

    build_ex_reports(response.params[:ex_reports].to_a)
  end
```

```rb
class Lbe::Moneyforward::Client

  def expenses(from:, to:)
    queries = [
      "query_object[recognized_at_from]=#{from.strftime('%Y-%m-%d')}",
      "query_object[recognized_at_to]=#{to.strftime('%Y-%m-%d')}",
    ]

    response = api_client.expenses(queries:)

    unless response.ok?
      raise Error, "MoneyForward API Error: #{response.response.body}"
    end

    response.params[:ex_transactions].to_a.map do |ex_transaction|
      Lbe::Moneyforward::Values::Expense.new(ex_transaction)
    end
  end
```

## 事実
- AWS Clowd Watch には、エラーが記録されていない("MoneyForward API Error")
- developから実施(dev dashboard)
  - 明細: `response.response.http_header.reason_phrase` #=> "Unauthorized"
  - レポート:

["WWW-Authenticate",
    "Bearer realm=\"Doorkeeper\", error=\"invalid_token\", error_description=\"\xE3\x82\xA2\xE3\x82\xAF\xE3\x82\xBB\xE3\x82\xB9\xE3\x83\x88\xE3\x83\xBC\xE3\x82\xAF\xE3\x83\xB3\xE3\x81\xAE\xE6\x9C\x89\xE5\x8A\xB9\xE6\x9C\x9F\xE9\x99\x90\xE3\x81\x8C\xE5\x88\x87\xE3\x82\x8C\xE3\x81\xBE\xE3\x81\x97\xE3\x81\x9F\""],

## 仮説
トークンの期限切れじゃね？
"アクセストークンの有効期限が切れました"

## 作業
https://lbejzeroichi.kibe.la/notes/142
再実施

### step1 認可コードを取得する
CLIENT_IDは、アプリーケーションID = HIRPYxfPvcNEKKmA1_COLM3Dqo09SXZZsUpcnkyy8GY
REDIRECT_URLは、コールバックURL

ブラウザアクセス
```sh
https://expense.moneyforward.com/oauth/authorize?client_id=HIRPYxfPvcNEKKmA1_COLM3Dqo09SXZZsUpcnkyy8GY&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&scope=office_setting:write user_setting:write transaction:write report:write public_resource:read
```

認可コード = wpqHuqIzVjsyT1rdHDClcE3e9IVMoyytrFTBgRLAxgg

### step2 アクセストークンを取得する
```sh
curl -d client_id=HIRPYxfPvcNEKKmA1_COLM3Dqo09SXZZsUpcnkyy8GY -d client_secret=t3Y0r0KFdxYbP-8t88iXI5wWu0bMSqP__z7agN3PW6g -d redirect_uri=urn:ietf:wg:oauth:2.0:oob -d grant_type=authorization_code -d code=wpqHuqIzVjsyT1rdHDClcE3e9IVMoyytrFTBgRLAxgg -X POST https://expense.moneyforward.com/oauth/token
```



{
  "access_token": "GR4nQWbacTv2klTPwrtl-5v2xc3L3TgJSljQovhB2gE",
  "token_type": "Bearer",
  "expires_in": 7775999,
  "refresh_token": "JQ4x7gbqWx1gWIG5Cfqwdby5fxt4qkti3lZ9aFZw_zk",
  "scope": "office_setting:write user_setting:write transaction:write report:write public_resource:read",
  "created_at": 1705999769
}
