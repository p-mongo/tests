# README

Requires Rails 6.

Generate the app:

    rails new --api spring-ar-sqlite-6
    cd spring-ar-sqlite

Edit `Gemfile`, removing reference to `sqlite`.

Edit `config/application.rb`, commenting out ActiveRecord and ActiveStorage:

    #require "active_record/railtie"
    #require "active_storage/engine"

Run:

    rails g controller foo
