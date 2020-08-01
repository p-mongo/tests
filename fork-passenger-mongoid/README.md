# Passenger + forking misuse

Run with:

    bundle exec passenger

Then:

    curl -v localhost:3000

Comment out the PhusionPassenger block in config.ru to get NoServerAvailable error.

Unlike puma & unicorn, this test does not close the client in the parent process.
