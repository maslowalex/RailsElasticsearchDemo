# Dockerized Rails 6

This is an example Rails 6 app on Docker. The purpose of this repo is to learn more about Docker, Docker-compose and Elasticsearch.
If you are so brave and you want to try it out:

- pull this repo to your local machine
- run `docker-compose up --build`
- `make db-create` and `make db-migrate`
- `make bash` and than whithin container `bundle exec rake import_chars` to import Rick and Morty characters from API and populate to DB and Elasticsearch

For testing inside docker:
- `make test-provision`
- `make rspec`

