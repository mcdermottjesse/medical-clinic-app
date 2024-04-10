# README

# Medicalitas 

An application that tracks the health and well being of medical patients.

## Ruby version

3.1.0

## Rails version

7.0.2.3

## System dependencies

yarn -v 1.22.19
node -v v16.14.2
Bundler version 2.3.11

## Server Command

./bin/dev (allows yarn to watch esbuild)

## Host

http://localhost:3000/

## Migrate Test Database

bin/rails db:migrate RAILS_ENV=test

## Start Rails in Test Environment

This app uses Cypress for end to end testing.

rake db:test:prepare
RAILS_ENV=test CYPRESS=1 bin/rails server -p 5017

## RSPEC command

bundle exec rspec file_path

## Seed test db

rails db:seed RAILS_ENV=test
