websocketを本番サーバで利用可能にする(2f4d68d2ec)
---

## 参考資料
[kibela 2024-04-08_WebSocketの対応](https://lbejzeroichi.kibe.la/notes/273)

## 状況
### ローカル環境
動作確認済み

### 本番環境
- ActionCableによる通信のうち、ReactからRailsに対しての通信は、ログから確認済み
  - 抜粋: "message":"Failed to upgrade to WebSocket (REQUEST_METHOD: GET, HTTP_CONNECTION: close, HTTP_UPGRADE: )"
  - 意味: WebSocket接続のアップグレードに失敗した
  - 説明: クライアントのHTTP接続は成功し、WebSocket通信へのアップグレード要求が断られた
  - ヒント:
    - HTTP_CONNECTION: close ではなく、 Upgrade であるべき
    - HTTP_UPGRADE:     空っぽ ではなく、 websocket であるべき
- ログの詳細
```log
{"host":"020a7d9f7af0","application":"Semantic Logger","environment":"production","timestamp":"2024-04-01T14:23:38.608471Z","level":"error","level_index":4,"pid":1,"thread":"puma srv tp 005","file":"/usr/local/bundle/gems/actioncable-7.0.4.2/lib/action_cable/connection/tagged_logger_proxy.rb","line":38,"named_tags":{"request_id":"026adf86-7c6f-4197-b9f7-85c91526226d","ip":"14.12.7.225","referer":"none"},"name":"ActionCable","message":"Failed to upgrade to WebSocket (REQUEST_METHOD: GET, HTTP_CONNECTION: close, HTTP_UPGRADE: )"}
{"host":"020a7d9f7af0","application":"Semantic Logger","environment":"production","timestamp":"2024-04-01T14:23:38.608570Z","level":"info","level_index":2,"pid":1,"thread":"puma srv tp 005","named_tags":{"request_id":"026adf86-7c6f-4197-b9f7-85c91526226d","ip":"14.12.7.225","referer":"none"},"name":"ActionCable","message":"Finished \"/cable\"[non-WebSocket] for 14.12.7.225 at 2024-04-01 14:23:38 +0000"}
```

### 調査
#### Upgradeが空になる原因
リバースプロキシまたはロードバランサーの設定問題: 本番環境では、多くの場合、アプリケーションの前にリバースプロキシ（Nginx、Apacheなど）やロードバランサーが配置されます。これらの中間層がWebSocketプロトコルのアップグレードリクエストを適切に処理していない、または必要なヘッダーを削除してしまっている可能性があります。特に、ConnectionやUpgradeヘッダーを適切に転送する設定が必要です。

#### Upgradeが空になっている人の質問と対策
https://serverfault.com/questions/1116900/have-nginx-automatically-upgrade-websocket-connections-in-reverse-proxy

```nginx
server {
  listen          443 ssl;
  server_name     my-server.example
  location / {
    proxy_pass http://local-service.example/;
    proxy_http_version 1.1;
    proxy_read_timeout 86400s;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";

  }
}
```

## 対策のおおまかな方針
- 「nginxの設定を修正して、nginxを再起動する」をできるようにする
  - [web_server](https://github.com/zeroichi-hacker/web_server) を修正する
    - featureブランチで作業する
    - うまくいったら、mainブランチにマージする
    - Lambdaのrestartスクリプトで、featureブランチを使ってくれるかを確認する
  - if Lambdaのrestartスクリプトが、mainブランチをpullしてきて、使っている場合
    - Lambdaのrestartスクリプトを修正する
    - これは、どこかにリポジトリがある？リポジトリは修正しなくていい？
- 作業手順書を作成する
- 古賀さんと、作業日程を調整する
  - 月火水の夜どこかで直接本番サーバーに修正する
- リリースを行う

## Lambdaのrestartスクリプト
Lambdaのスクリプトが実行するスクリプト はここにあります
https://github.com/zeroichi-hacker/ec2_scripts

restart はこいつ
https://github.com/zeroichi-hacker/ec2_scripts/blob/main/scripts/restart.rb

ちなみに deploy はこいつです
https://github.com/zeroichi-hacker/ec2_scripts/blob/main/scripts/deploy.rb

ぱっと見ると WebServer 側はgit pull とかしてなさそうですね
https://github.com/zeroichi-hacker/ec2_scripts/blob/main/scripts/deploy.rb#L52

## TODO
- ✅状況確認
- ✅対策のおおまかな方針
- ✅原因の推定（ローカルで再現できないので、推定になる。nginxの修正が妥当だということが確認できればOK）
- 🟡nginxの設定を修正
  - 🔥修正をfeatureブランチで行うこと
    - ~/Github/zeroichi-hacker/web_server
      - confs/nginx.conf
    - [web_server](https://github.com/zeroichi-hacker/web_server)
  - ✅影響範囲を確認
- ✅Lambdaのrestartスクリプトの確認 & 修正 → 修正不要
- 🟡作業手順書の作成（ロールバック手順も！）
- ✅古賀さんと作業日程を調整する
- リリースを行う
- 報告する

## 気をつけること
