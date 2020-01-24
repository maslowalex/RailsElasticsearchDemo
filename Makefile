RAILS_ENV ?= development

DOCKER_COMPOSE := docker-compose -f docker-compose.yml

up:
	${DOCKER_COMPOSE} up

down:
	${DOCKER_COMPOSE} down

rails-s:
	${DOCKER_COMPOSE} run --service-ports --rm -e development web bundle exec rails s -b 0.0.0.0

rails-c:
	${DOCKER_COMPOSE} run --rm web bundle exec rails c

db-migrate:
	${DOCKER_COMPOSE} run --rm web bundle exec rails db:migrate

db-create:
	${DOCKER_COMPOSE} run --rm web bundle exec rails db:create

bash:
	${DOCKER_COMPOSE} run --rm web bash

test-provision: test-bundle-install test-migrate

test-bundle-install:
	${DOCKER_COMPOSE} run --rm -e "RAILS_ENV=test" web bundle install

test-migrate:
	${DOCKER_COMPOSE} run --rm -e "RAILS_ENV=test" web bundle exec rails db:migrate

rspec:
	${DOCKER_COMPOSE} run --rm web bundle exec rspec