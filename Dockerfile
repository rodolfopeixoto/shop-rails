FROM ruby:2.4
ENV http_proxy http://10.131.188.1:80
ENV https_proxy http://10.131.188.1:80
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /shop
WORKDIR /shop
ADD Gemfile /shop/Gemfile
ADD Gemfile.lock /shop/Gemfile.lock
RUN bundle install
ADD . shop

