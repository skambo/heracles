#!/bin/sh

set -e # fail fast
set -x # print commands

rspec tests/ui/*.rb
