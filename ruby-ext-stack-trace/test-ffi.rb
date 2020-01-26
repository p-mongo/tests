require 'ffi'

module Foo
  extend FFI::Library

  ffi_lib 'shlib/lib.so'


  attach_function :foo, [], :void
end

Foo.foo
