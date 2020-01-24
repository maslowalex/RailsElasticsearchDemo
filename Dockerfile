FROM ruby:2.6

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev curl postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs yarn

RUN mkdir /elastic_example
WORKDIR /elastic_example/app
COPY Gemfile /elastic_example/Gemfile
COPY Gemfile.lock /elastic_example/Gemfile.lock
RUN bundle install

RUN bundle exec rails webpacker:install
COPY . /elastic_example

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
