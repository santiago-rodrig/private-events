# Private events

This repository is intended to be an associations practice using Rails,
the instructions for this practice project can be found in
[TOP site](https://www.theodinproject.com/courses/ruby-on-rails/lessons/associations).

In summary, this is the backend of an event's site that has users and events
related in many ways.

## Requirements

Here is a list of dependencies of this app.

- `rails` 5.1.7
- `ruby` 2.6.5
- `bundler` 2.0.2
- `yarn` 1.19.2
- `sqlite3` 3.27.2

## Setup

Copy and paste the following chain of commands in your terminal as a regular
user. This should work in Linux and Mac operative systems.

```shell
git clone --single-branch --branch 'feature/private-events' \
https://github.com/santiago-rodrig/private-events && \
cd private-events && bundle install && yarn install --check-files && \
rails db:reset && rails db:reset RAILS_ENV=test && rails db:migrate && \
rails db:migrate RAILS_ENV=test
```

## Test suite

To run the tests that verify the proper behavior of the Rails app, run the
following command. There are about **82 passing specs**, this should make you
stop worrying about a malfunction in the app.

```shell
rspec
```

## Launching

Just run `rails server`. Then visit [localhost:3000](http://localhost:3000/).
If for some reason you have a server running in that same port just change
the port with `rails server -p XXXX`, where `XXXX` is any number greater than
1024 (below that we have permission troubles). For example `3001` could work.
