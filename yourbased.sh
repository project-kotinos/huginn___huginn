#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
export CI=true
export TRAVIS=true
export CONTINUOUS_INTEGRATION=true
export USER=travis
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RAILS_ENV=test
export RACK_ENV=test
export MERB_ENV=test

#before_install:
gem update --system
gem install bundler

apt-get install libcurl4-openssl-dev
#install
bundle install --without development production

#script:
if [ -z "${DOCKER_IMAGE}" ]; then bundle exec rake db:create db:migrate; else true; fi
if [ -z "${DOCKER_IMAGE}" ]; then bundle exec rake; else ./build_docker_image.sh; fi
