FROM ruby:3.1.2

RUN apt-get install bash

WORKDIR /api

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 3082
RUN chmod +x ./entrypoints/entrypoint-dev.sh
