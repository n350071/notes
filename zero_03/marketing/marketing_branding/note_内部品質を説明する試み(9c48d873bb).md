
---

ゼロイチハッカーでは、オブジェクト指向設計におけるSRP（Single Responsibility Principle）を意識して、クラスの責務を明確にすることを推奨しています。
クラスの責務を明確にすることで、クラスの再利用性が向上し、保守性が高まります。
その例を見ていきましょう。


---

## 例
### リファクタリング前のコード
```rb
class ApiKey
  def initialize(client_id, client_secret, token_url)
    @client_id = client_id
    @client_secret = client_secret
    @token_url = token_url
  end

  def get_access_token
    # アクセストークンを取得する処理
  end

  def def refresh_access_token(refresh_token, client_id, client_secret, refresh_url)
    # アクセストークンをリフレッシュする処理
    uri = URI.parse(refresh_url)

    # リフレッシュトークンとクライアントの認証情報を含むリクエストボディを作成
    request_body = {
      grant_type: 'refresh_token',
      refresh_token: refresh_token,
      client_id: client_id,
      client_secret: client_secret
    }

    # HTTPリクエストの作成
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https' # HTTPSを使用する場合
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/x-www-form-urlencoded'})
    request.set_form_data(request_body)

    # HTTPリクエストの送信
    response = http.request(request)

    # レスポンスの解析
    if response.code == '200'
      # 成功した場合、新しいアクセストークン（および場合によっては新しいリフレッシュトークン）を抽出
      body = JSON.parse(response.body)
      access_token = body['access_token']
      # 新しいリフレッシュトークンがあれば更新（APIによっては提供されないこともあります）
      refresh_token = body['refresh_token'] if body.key?('refresh_token')
      return access_token, refresh_token
    else
      # エラーの場合、メッセージを表示
      puts "Failed to refresh access token: #{response.body}"
      return nil, nil
    end
  end
end
```

### リファクタリング後のコード
```rb
# トークン取得のためのクライアント認証情報を保持するクラス
class ApiClient
  attr_reader :client_id, :client_secret, :token_url

  def initialize(client_id, client_secret, token_url)
    @client_id = client_id
    @client_secret = client_secret
    @token_url = token_url
  end
end

# HTTPリクエストを扱うユーティリティクラス
class HttpRequester
  def self.post(uri, request_body, use_ssl: false)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = use_ssl if uri.scheme == 'https'
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/x-www-form-urlencoded'})
    request.set_form_data(request_body)
    http.request(request)
  end
end

# アクセストークンの管理を担当するクラス
class TokenManager
  def initialize(api_client)
    @api_client = api_client
  end

  def refresh_access_token(refresh_token)
    uri = URI.parse(@api_client.token_url)
    request_body = {
      grant_type: 'refresh_token',
      refresh_token: refresh_token,
      client_id: @api_client.client_id,
      client_secret: @api_client.client_secret
    }

    response = HttpRequester.post(uri, request_body, use_ssl: uri.scheme == 'https')
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.code == '200'
      body = JSON.parse(response.body)
      [body['access_token'], body['refresh_token']]
    else
      puts "Failed to refresh access token: #{response.body}"
      [nil, nil]
    end
  end
end
``````
