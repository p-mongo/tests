# Puma + forking misuse

Run with:

    puma -w 2 --preload config.ru

Then:

    curl -v localhost:9292

You'll get NoServerAvailable error.
