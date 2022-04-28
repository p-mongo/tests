# Ruby 2.6.7p197 (2021-04-05 revision 67941) [x86_64-darwin20]
# Mongoid 7.3.0

require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:27017'],
    database: 'memory_bloat',
  }

  config.log_level = :warn
end

class Base
  def self.inherited(sub_class)
    super

    sub_class.class_eval do
      include Mongoid::Document
      include Mongoid::Timestamps
    end
  end
end

class Company < Base
  embeds_many :departments

  attr_reader :employee_models

  after_initialize do
    @employee_models = departments.map do |department|
      Object.send :remove_const, department.employee_model_name if Object.const_defined? department.employee_model_name

      Object.const_set(
        department.employee_model_name,
        Class.new(Base) do
          store_in collection: "d#{department.id}_employees"

          department.employee_fields.each do |employee_field|
            field employee_field.name, type: employee_field.value_type
          end
        end,
      )
    end
  end

  field :name, type: String
end

class Department < Base
  embedded_in :company
  embeds_many :employee_fields

  field :name, type: String

  def employee_model_name
    "D#{id}Employee"
  end
end

class EmployeeField < Base
  embedded_in :department

  field :name, type: :stringified_symbol
  field :value_type, type: :stringified_symbol
end

Company.create!(
  name: 'Company1',
  departments: [
    {
      name: 'IT',
      employee_fields: [
        { name: 'name', value_type: 'string' },
        { name: 'email', value_type: 'string' },
        { name: 'server_room_access', value_type: 'boolean' },
      ],
    },
    {
      name: 'HR',
      employee_fields: [
        { name: 'name', value_type: 'string' },
        { name: 'email', value_type: 'string' },
        { name: 'payroll_access', value_type: 'boolean' },
      ],
    },
  ],
)

puts 'Model instance count:'
puts(ObjectSpace.each_object(Base).each { |i| p [i.class, i.id.to_s] })

Company.last
Company.last
Company.last

puts "\nModel instance count after 3 finds:"
puts(ObjectSpace.each_object(Base).each { |i| p [i.class, i.id.to_s] })

GC.start

puts "\nModel instance count after GC:"
puts(ObjectSpace.each_object(Base).each { |i| p [i.class, i.id.to_s] })

Mongoid.purge!
