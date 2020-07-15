require 'mongoid'


# ...

class Parent
  include Mongoid::Document

  self.discriminator_key = 'foo'
end

Parent.fields
# _id

class Child < Parent
end

Parent.fields
# _id, foo


class Parent
  self.discriminator_key = 'bar'
end

Parent.fields
# _id, foo, bar

Mongoid.discriminator_key = 'baz'

class Spongebob
  include Mongoid::Document
end

# ...

Spongebob.fields
# _id, baz
