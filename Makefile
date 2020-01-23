RAILS_ENV ?= development

DOCKER_COMPOSE := docker-compose -f docker-compose.yml

up:
	${DOCKER_COMPOSE} up

rails-c:
	${DOCKER_COMPOSE} run --rm web bundle exec rails c

migrate:
	${DOCKER_COMPOSE} run --rm web bundle exec rails db:migrate

db-create:
	${DOCKER_COMPOSE} run --rm web bundle exec rails db:create

bash:
	${DOCKER_COMPOSE} run --rm web bash
