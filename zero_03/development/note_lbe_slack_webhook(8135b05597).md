lbe_slack_webhook(8135b05597).md
---

## slack inoming webhooks: feature/v1.x/jupiter
- 設定箇所
  - https://api.slack.com/apps/A05JC0DSLCB/incoming-webhooks?
- 得られたwebhook URL
  - https://hooks.slack.com/services/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
- lib/zeroichi_tools/error_notification.rb
  - ZeroichiTools::ErrorNotification
    - webhook_url:
- テスト
```sh
curl -X POST -H 'Content-type: application/json' --data '{"text":"テストです。「エラーが送信されました！」"}' https://hooks.slack.com/services/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
```
- GitHub
  - https://github.com/zeroichi-hacker/lbe/pull/373




