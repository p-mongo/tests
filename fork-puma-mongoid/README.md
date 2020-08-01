# Puma + forking misuse

Run with:

    puma -w 2 --preload config.ru

Then:

    curl -v localhost:9292

You'll get NoServerAvailable error.

To fix, use the config file with before_fork/on_worker_boot hooks:

    puma -c puma.rb

Uncomment the hooks in the config file to get NoServerAvailable again.
