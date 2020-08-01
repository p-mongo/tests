# Unicorn + forking misuse

Run with:

    bundle exec unicorn -c unicorn.rb

Then:

    curl -v localhost:8080

Uncomment the hooks in the config file to get NoServerAvailable error.
