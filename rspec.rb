# ときどき、テスト用のDBが更新されていないときがある
# とくに rake db:rollbackしたあと
# そのときは、
# rake db:rollback RAILS_ENV=test
# rake db:migrate RAILS_ENV=test
