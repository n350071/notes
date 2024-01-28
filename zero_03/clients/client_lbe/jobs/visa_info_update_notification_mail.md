
ローカルで実行するスクリプト

```rb
visa_leaders = {}
visa_leaders[:before_14days] = Leader.first(2)
visa_leaders[:today] = Leader.first(1)
visa_leaders[:after_30days] = Leader.last(2)

graduated_leaders = {}
graduated_leaders[:before_14days] = Leader.first(2)
graduated_leaders[:today] = Leader.first(1)
graduated_leaders[:after_30days] = Leader.last(2)

AdminMailer.visa_info_update_notification_mail(visa_leaders, graduated_leaders).deliver_now
```
