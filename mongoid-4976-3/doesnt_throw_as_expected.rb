=begin
Doesn't throw as expected if own attribute present.
=end

require 'byebug'
require 'mongoid'


Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid_config.yml'), :development)


class User
	include Mongoid::Document

	embeds_one	:auth_data,	class_name: 'UserAuthData',	autobuild: true
	accepts_nested_attributes_for	:auth_data
	validates						:auth_data,	presence: true
end


class UserAuthData
	include Mongoid::Document

	embedded_in :user

        validate :foo

        def foo
          errors.add(:bar, 'bar')
          byebug
        end

        def initialize(*params)
          p 'init uad'
          byebug
          super
        end
end


u = User.create!#(auth_data: UserAuthData.new)
p u
p u.auth_data
#p u.valid?
