note_pwaについて(1bfbb24ede)
---

## ハラサポでのPWA化作業
https://github.com/zeroichi-hacker/harasapo/pull/45

## サービスワーカー
- ブラウザがバックグラウンドで実行するスクリプト
- プッシュ通知やバックグラウンド同期といったモダンなWeb技術を使用するための基盤となる技術
- ブラウザとインターネットの間に位置するプロキシサーバーのような役割
- Service Workerとウェブアプリケーションのメインスレッドはポストメッセージを通して通信する
- Service Workerの登録は、訪問するだけ
- 登録されているService Worker の一覧は、chrome://serviceworker-internals/ で確認できる
- ServiceWorkerのライフサイクル
https://ugo.tokyo/about-service-worker/