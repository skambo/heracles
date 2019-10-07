#!/bin/sh

set -e # fail fast
set -x # print commands

shotgun && bundle exec rspec tests/ui/*.rb
