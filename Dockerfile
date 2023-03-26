FROM ruby:3.1.2

RUN apt-get install bash

WORKDIR /api

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 8080
ENV PORT=8080
ENV RAILS_ENV='production'
RUN chmod +x ./entrypoints/entrypoint-dev.sh
RUN chmod +x ./entrypoints/entrypoint-prod.sh

ENTRYPOINT [ "./entrypoints/entrypoint-prod.sh" ]
