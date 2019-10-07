#!/bin/sh

set -e # fail fast
set -x # print commands

bundle exec rspec tests/ui/*.rb
