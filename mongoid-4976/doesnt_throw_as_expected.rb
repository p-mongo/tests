=begin
Doesn't throw as expected if own attribute present.
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
	validates						:username,	presence: true,  uniqueness: true,  allow_blank: false

	field  :username, type: String

	index({'username':				1}, {unique: true})
	index({'auth_data.email':		1}, {unique: true})
end


class UserAuthData
	include Mongoid::Document

	embedded_in :user
	validates	:email,  presence: true, allow_blank: false

	field  :email,  type: String
end


u = User.create! username: 'some_name', auth_data: {}

p u
