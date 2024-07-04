GoogleアラートをSlackで通知する方法
---

- まずは「Googleアラート」にアクセス
  - https://www.google.co.jp/alerts#
- サブスクしたいものを入力する
  - キーワード
    - 小学生ロボコン
  - サイト
    - site:https://fukufuku-sato.com/
- RSSボタンをクリックし、遷移先のアドレスバーからRSSフィードのURLをコピーします
  - 例: https://www.google.co.jp/alerts/feeds/13366694257846119484/4886300225087864551
- 通知を飛ばしたいSlaclのチャンネル上で、/feed + コピーしたURL を送信します
  - 例: /feed https://www.google.co.jp/alerts/feeds/13366694257846119484/4886300225087864551
  - slack bot が反応すれば成功