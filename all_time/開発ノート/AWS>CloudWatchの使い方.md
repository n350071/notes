# AWS>CloudWatchの使い方
## ロググループのログの検索
### 公式記事
[フィルターとパターンの構文](https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html#matching-terms-events)

### 例: ayushgiri58@gmail.com が入っているログを検索する
#### JSONログイベント
```json
{
    "host": "976b1bb499e3",
    "application": "Semantic Logger",
    "environment": "production",
    "timestamp": "2023-07-13T02:24:59.600008Z",
    "level": "info",
    "level_index": 2,
    "pid": 1,
    "thread": "puma srv tp 004",
    "duration_ms": 7.9904632568359375,
    "duration": "7.990ms",
    "named_tags": {
        "request_id": "a603f796-546f-443f-812b-cb8215118adc",
        "ip": "106.130.49.60",
        "referer": "https://lbejapan.net/leader/externals/programs/41/auth?access_token=pR3YSJ6nCWVqDxc8hXjlem2OHuJY7Hxp8NS-d-kriA0"
    },
    "name": "Leader::Externals::Programs::AuthsController",
    "message": "Completed #create",
    "payload": {
        "controller": "Leader::Externals::Programs::AuthsController",
        "action": "create",
        "params": {
            "authenticity_token": "[FILTERED]",
            "access_token": "[FILTERED]",
            "email": "ayushgiri58@gmail.com",
            "password": "[FILTERED]",
            "program_id": "41"
        },
        "format": "HTML",
        "method": "POST",
        "path": "/leader/externals/programs/41/auth",
        "status": 500,
        "view_runtime": 1.35,
        "db_runtime": 2.31,
        "allocations": 2629,
        "status_message": "Internal Server Error"
    }
}
```

### 検索について
- 検索クエリがあっていても、範囲指定しないと、いつまでもグルグルすることがある。
  - 日付や時間を範囲指定しよう

#### 検索クエリ

以下のJSONログイベントの場合は、このようにイベントフィルターに以下を入力する
```json
{ $.payload.params.email = "ayushgiri58@gmail.com" }
{ $.payload.params.email = "*@lbejapan.co.jp" }
{ $.payload.params.email = "hori@lbejapan.co.jp" }
```

```json
{ ($.payload.params.email = "ayushgiri58@gmail.com") && ( $.payload.params.status_message != "Internal Server Error" ) }
```

```json
{ ($.named_tags.ip = "106.130.49.60") && ($.payload.params.email = "*@lbejapan.co.jp") }
{ ($.named_tags.ip = "106.130.49.60") && ($.payload.params.email = "ayushgiri58@gmail.com") }

```

```json
{ $.payload.path = "/" }
```



### 例: Rails.logger.info("heartbeat running.")を探す
#### JSONイベント
```json
{
  "host": "976b1bb499e3",
  "application": "Semantic Logger",
  "environment": "production",
  "timestamp": "2023-07-20T03:04:17.001363Z",
  "level": "info",
  "level_index": 2,
  "pid": 16,
  "thread": "103260",
  "name": "Rails",
  "message": "heartbeat running."
}
```
#### 検索
```json
{ $.message = "heartbeat running." }
```

## その他、検索クエリ作成メモ
### ErrorHashCode を調べる
```json
{
  "host": "976b1bb499e3",
  "application": "Semantic Logger",
  "environment": "production",
  "timestamp": "2023-08-03T00:37:49.550061Z",
  "level": "error",
  "level_index": 4,
  "pid": 1,
  "thread": "puma srv tp 005",
  "file": "/app/app/forms/leader/externals/programs/expenses/form.rb",
  "line": 54,
  "named_tags": {
    "request_id": "48f95e37-98d1-4926-9a8f-0fce9262176e",
    "ip": "153.216.99.190",
    "referer": "https://lbejapan.net/leader/externals/programs/58/expenses/edit"
  },
  "name": "Rails",
  "message": "ErrorHashCode: 0f6090c80e. [\"Order has already been taken\"]. {\"id\":null,\"remarks\":\"Bus from mochigahama to beppu eki (return trip)\",\"fare\":300,\"category\":\"local\",\"order\":1,\"program_join_leader_expense_id\":335,\"leader_id\":594,\"program_id\":58,\"created_at\":null,\"updated_at\":null,\"file\":{\"url\":null},\"original_filename\":null,\"no_receipt\":false}"
}
```

```json
{ $.message = "*0f6090c80e*" }
{ $.message = "*e0714a16be*" }
{ $.message = "*fa70801552*" }
{ $.message = "*ProgramEmployeeの保存に失敗しました*" }
{ $.message = "*Start ScheduledTasks::RunNotifyRemindExpenseRequest.task_run*" }
{ $.level = "error" }
{ ($.level = "info") && ($.message = "*debug SyncProgramEmployee:*") }
{ $.message = "*SyncProgramEmployee*" }
{ ($.message = "*ProgramEmployeeの保存に失敗しました。*") && ($.message != "*Employee must exist*") }
{ $.message = "*MoneyForward API Error*" }
{ $.message = "*AiFeatures::ProgramInstruction.create*" }
```

## 例
### ログ出力
Rails.logger.info("Leaders::VisaInfoUpdateNotificationService#run")

### 検索
```json
{ $.message = "Leaders::VisaInfoUpdateNotificationService#run" }
```

### 結果
```json
{
    "host": "020a7d9f7af0",
    "application": "Semantic Logger",
    "environment": "production",
    "timestamp": "2025-04-22T00:00:00.074111Z",
    "level": "info",
    "level_index": 2,
    "pid": 17,
    "thread": "176300",
    "name": "Rails",
    "message": "Leaders::VisaInfoUpdateNotificationService#run"
}
```


---


## 例
### ログ出力
```ruby
_message = "CSV import error: #{e}"
Rails.logger.error(_message)
```

### 検索
```json
{ ($.level = "error") && ($.message = "*CSV import error:*") }
```

### 結果
```json
{
    "host": "020a7d9f7af0",
    "application": "Semantic Logger",
    "environment": "production",
    "timestamp": "2025-06-11T07:19:27.216957Z",
    "level": "error",
    "level_index": 4,
    "pid": 1,
    "thread": "puma srv tp 005",
    "file": "/app/app/models/domains/leaders/import_csv.rb",
    "line": 123,
    "named_tags": {
        "request_id": "fcd9fd03-9b83-4d1e-8396-5678d35059b9",
        "ip": "114.164.197.50",
        "referer": "https://lbejapan.net/staff/leaders"
    },
    "name": "Rails",
    "message": "CSV import error: Validation failed: Branch name can't be blank"
}
```

```

