# rakeタスク

### list the rake tasks
```
bundle exec rake -XT
bundle exec rake -T -A
```

### ActiveRecord::PendingMigrationError

```
$bundle exec rake db:migrate:status

up     20180801105656  Add index to xxx
up     20180801253463  Add index xxx to yyy
down   20180811342424  Add timestanps to something

$bundle exec db:migrate RAILS_ENV=development
```

### Routing

```
bundle exec rake routes | grep some_resource
```
http://localhost:3000/rails/info/routes

### Making rake task

- make a file under `/lib/tasks/`
  - example: `/lib/tasks/db:migrate:do_it.rake`
- write your task
```
namespace 'eat' do
  desc "せつめい。rake -XTしたときに右側に表示される"
  task :sandwich => :environment do
    sandwich = Sandwich.first
    person = Person.first.eat(sandwich).save
  end
end
```
- run it
  - 'bundle exec rake eat:sandwich'
