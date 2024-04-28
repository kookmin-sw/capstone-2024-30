FROM ruby:3.0.2-slim

WORKDIR /app

RUN apt-get update
RUN apt-get install -y build-essential apt-utils libpq-dev nodejs default-mysql-client default-libmysqlclient-dev

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

COPY . /app

EXPOSE 3000

ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]