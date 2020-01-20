# Private events

This repository is intended to be an associations practice using Rails,
the instructions for this practice project can be found in
[TOP site](https://www.theodinproject.com/courses/ruby-on-rails/lessons/associations).

In summary, this is the backend of an event's site that has users and events
related in many ways.

## Setup

Copy and paste the following chain of commands in your terminal as a regular
user. This should work in Linux and Mac operative systems.

```shell
git clone --single-branch --branch 'feature/private-events' \
https://github.com/santiago-rodrig/private-events &&
cd private-events && rails db:reset && rails db:migrate
```

## Test suite

To run the tests that verify the proper behavior of the Rails app, run the
following command.

```shell
rails spec
```
