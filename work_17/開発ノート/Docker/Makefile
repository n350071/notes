help:
	cat Makefile

init:
	make build
	docker-compose run web bundle exec rails db:create
	docker-compose run web bundle exec rails db:migrate
	docker-compose run web bundle exec rails db:seed

install:
	docker-compose run web bundle install
	docker-compose run web yarn install

build:
	docker-compose build
	make install

migrate:
	docker-compose exec web bundle exec rails db:migrate

rollback:
	docker-compose exec web bundle exec rails db:rollback
	docker-compose exec web bundle exec rails db:rollback RAILS_ENV=test

up:
	docker-compose up

stop:
	docker-compose stop

down:
	docker-compose down

debug:
	docker-compose run --service-ports web bundle exec rails s -b 0.0.0.0

console:
	docker-compose exec web bundle exec rails console

ssh:
	docker-compose exec web bash
