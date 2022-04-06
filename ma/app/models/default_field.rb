module LocalDefault
  extend ActiveSupport::Concern

  class_methods do
    def local_default(*field_names)
      field_names.each do |field_name|
        define_method("#{field_name}=") do |v|
        byebug
        x
          if fields[field_name]
          byebug
          1
          x
          end
        end
      end
    end
  end
end

class DefaultField
  include Mongoid::Document
  include LocalDefault

  field :foo, type: String, default: 'a foo'
  local_default :foo
end
