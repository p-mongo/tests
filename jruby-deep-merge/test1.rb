gem 'i18n', '1.8.8'
gem 'activesupport'

require 'active_support'
require 'active_support/core_ext'
require 'i18n'

backend = I18n::Backend::Simple.new
backend.store_translations(:en, {})
