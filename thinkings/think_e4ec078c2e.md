# think_e4ec078c2e.md
## タイトル
（🐛）デフォルトで、食費などが反映されない

## 状況
Slackで問い合わせ中。
動いているよ？

## 原因調査
app/controllers/leader/programs/expenses_controller.rb
```rb
  def expense
    program_join_leader.find_or_create_default_expense
  end
```

(推測)
こちらは動いているが、そもそも仕様変更によって、
ここでcreateされる前に、create済みになっており、
そのcreateするタイミングでは、default_expenseが反映されていない仕組みになっている
