#!/bin/bash
bundle config set --local path 'vendor/bundle'
bundle install
bundle exec jekyll serve
