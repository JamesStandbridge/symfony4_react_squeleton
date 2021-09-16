FROM ruby:2.4-alpine

COPY Gemfile /work/Gemfile
COPY Gemfile.lock /work/Gemfile.lock

WORKDIR /work

RUN gem install bundler
RUN bundle install

COPY ./docker/capistrano/ssh_config /root/.ssh/config
