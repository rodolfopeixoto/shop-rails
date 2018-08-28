FROM ruby:2.4
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  xvfb \
  qt5-default \
  libqt5webkit5-dev \
  gstreamer1.0-plugins-base \
  gstreamer1.0-tools \
  gstreamer1.0-x


RUN mkdir /shop
WORKDIR /shop
ADD Gemfile /shop/Gemfile
ADD Gemfile.lock /shop/Gemfile.lock
RUN bundle install
ADD . shop

