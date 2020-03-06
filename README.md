# Introduction
This repo contains a small PoC used to check the viability of having something 'easy' to deliver to hackerspaces in order to maintain events on a calendar. The idea behind it, is that this service gets scraped by hackeropuit.nl.

# Getting started
~~~~
$ make
$ docker-compose up
~~~~

# Test credentials
The following users are available for authentication. They use their username as a password:
- admin
- test
- readonly

# Next steps
Navigate to radicale on http://localhost:8080/radicale/, and login as the test user. Create a new collection.
Navigate to infCloud on http://localhost:8080/edit/, login as the test user, and mutate events
