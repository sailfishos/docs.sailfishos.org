#!/bin/bash
bundle config set --local path 'vendor/bundle'
bundle install
exec bundle exec jekyll serve $@
