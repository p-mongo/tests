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

Result:

    butler% rails g controller foo
    /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/2.6.0/bundler/rubygems_integration.rb:408:in `block (2 levels) in replace_gem': Error loading the 'sqlite3' Active Record adapter. Missing a gem it depends on? sqlite3 is not part of the bundle. Add it to your Gemfile. (LoadError)
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/connection_adapters/sqlite3_adapter.rb:13:in `<main>'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `block in require_with_bootsnap_lfi'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/loaded_features_index.rb:92:in `register'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:21:in `require_with_bootsnap_lfi'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/zeitwerk-2.2.0/lib/zeitwerk/kernel.rb:23:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/connection_adapters/connection_specification.rb:170:in `spec'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/connection_adapters/abstract/connection_pool.rb:1044:in `establish_connection'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/connection_handling.rb:51:in `establish_connection'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/railtie.rb:201:in `block (2 levels) in <class:Railtie>'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:72:in `class_eval'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:72:in `block in execute_hook'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:62:in `with_execution_control'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:67:in `execute_hook'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:52:in `block in run_load_hooks'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:51:in `each'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activesupport-6.0.0/lib/active_support/lazy_load_hooks.rb:51:in `run_load_hooks'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/base.rb:327:in `<module:ActiveRecord>'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activerecord-6.0.0/lib/active_record/base.rb:27:in `<main>'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `block in require_with_bootsnap_lfi'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/loaded_features_index.rb:92:in `register'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:21:in `require_with_bootsnap_lfi'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/zeitwerk-2.2.0/lib/zeitwerk/kernel.rb:23:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:370:in `active_record_configured?'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:287:in `disconnect_database'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:111:in `preload'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:157:in `serve'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:145:in `block in run'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:139:in `loop'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application.rb:139:in `run'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/spring-2.1.0/lib/spring/application/boot.rb:19:in `<top (required)>'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/core_ext/kernel_require.rb:54:in `require'
            from /home/sandbox/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/core_ext/kernel_require.rb:54:in `require'
            from -e:1:in `<main>'
