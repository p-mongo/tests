require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14400'],
    database: 'junk_db',
    options: {
      truncate_logs: false
    }
  }
  config.raise_not_found_error = false
end

class TestMemLeak
  include Mongoid::Document

  field :processed, type: Boolean, default: false
end





test_mem_leak = TestMemLeak.create!

    GC.start()
    syms = Symbol.all_symbols
    test_mem_leak.with(write: {w: 0, j: false}){|t| t.set(processed: true) }
    GC.start()
    new_syms = Symbol.all_symbols - syms
    puts new_syms

require 'byebug'
byebug

    GC.start()
    puts Symbol.all_symbols.size
    test_mem_leak.with(write: {w: 0, j: false}){|t| t.set(processed: true) }
    GC.start()
    puts Symbol.all_symbols.size
