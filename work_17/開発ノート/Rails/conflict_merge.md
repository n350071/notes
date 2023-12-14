```
git reset HEAD db/schema.rb
git checkout db/schema.rb
bundle exec rails db:migrate
git add db/schema.rb
git merge --continue
```
