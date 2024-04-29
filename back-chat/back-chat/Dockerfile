FROM ruby:3.0.2-slim

WORKDIR /app

RUN apt-get update
RUN apt-get install -y build-essential apt-utils libpq-dev default-mysql-client default-libmysqlclient-dev

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && RAILS_ENV=production bundle install --jobs 20 --retry 5

ENV RAILS_ENV=production

COPY . ./

