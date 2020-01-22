RAILS_ENV ?= development

DOCKER_COMPOSE := docker-compose -f docker-compose.yml

up:
	${DOCKER_COMPOSE} up

rails-c:
	${DOCKER_COMPOSE} run --rm web bundle exec rails c

bash:
	${DOCKER_COMPOSE} run web bash