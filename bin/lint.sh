#!/bin/sh

set -e # fail fast
set -x # print commands

bundle exec rubocop
