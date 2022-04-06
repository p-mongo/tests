task :test_4871 => :environment do

  class Org
    include Mongoid::Document

    field :created_at, type: String
  end

  Org.delete_all

  Org.create(created_at: Time.now.iso8601)

  p Org.first

  Object.class_eval do
    remove_const(:Org)
  end

  class Org
    include Mongoid::Document

    def created_at
      Time.parse(read_attribute(:created_at))
    end
  end

  p Org.first
  p Org.first.created_at
end
