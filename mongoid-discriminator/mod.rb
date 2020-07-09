module Payable
  def pay
  end

  def self.brackets
  end

  def self.included(base)
    base.class_eval do
      def salary
      end
    end

    class << base
      def salary_ranges
      end
    end
  end
end

module Performance
  def promote
  end
end

class Employee
  include Payable
  include Performance

  def hours
  end

  def self.allowable_hours
  end

  class << self
    def allowable_hours2
    end
  end
end

class Contractor
  include Payable
end

Employee.allowable_hours
Employee.allowable_hours2
Employee.new.salary
Employee.salary_ranges

Payable.brackets

#Employee.brackets
