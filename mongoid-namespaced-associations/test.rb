require 'byebug'
require "mongoid"



Mongoid.load!('mongoid.yml', 'development')



module Test1

  class Company

    include Mongoid::Document

    has_many :emails

  end



  class Email

    include Mongoid::Document

    belongs_to :company

  end

end



module Test2

  class Company

    include Mongoid::Document

    has_many :emails, class_name: "Test2::Email"

  end



  class Email

    include Mongoid::Document

    belongs_to :company, class_name: "Test2::Company"

  end

end



class Company

  include Mongoid::Document

  has_many :emails

end



class Email

  include Mongoid::Document

  belongs_to :company

end



def test(mod)

puts "test #{mod}"

  # setup

  c = eval("#{mod}::Company.create")

  e = eval("#{mod}::Email.create")

  e.company = c

  c.save

  e.save

  c.reload



  # check the emails array

  p c.emails
  byebug

  if c.emails.size == 1

    puts "success"

  else

    puts "failure"

  end



  # teardown

  c.destroy

  e.destroy

end



test("Test1")   # fails. Expecting a success

test("Test2")   # succeeds

test("")            # succeeds


