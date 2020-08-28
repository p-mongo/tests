=begin
All is well if no own attributes present.
Exception raised as expected.
=end

require 'mongoid'


Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14440'],
    database: 'my_db'
  }
end


class User
	include Mongoid::Document

	embeds_one	:auth_data,	class_name: 'UserAuthData',	autobuild: true
	accepts_nested_attributes_for	:auth_data
	validates						:auth_data,	presence: true
end


class UserAuthData
	include Mongoid::Document

	embedded_in :user
	validates	:email,  presence: true, allow_blank: false

	field  :email,  type: String
end


User.create! auth_data: {}