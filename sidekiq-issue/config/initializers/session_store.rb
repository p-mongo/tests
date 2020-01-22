# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :mongoid_store, key: '_web_session', expires: 10.years.from_now
