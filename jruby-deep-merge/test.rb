gem 'i18n', '1.8.9'
gem 'activesupport', '6.1.3'

require 'active_support/dependencies/autoload'
require 'active_support/core_ext/hash'

module Foo
end

Hash.prepend(Foo)


require 'i18n/core_ext/hash'

using I18n::HashRefinements

{}.deep_merge({})
Concurrent::Hash.new.deep_merge({})
