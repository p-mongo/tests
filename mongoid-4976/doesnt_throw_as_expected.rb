=begin
Doesn't throw as expected if own attribute present.
=end

require 'mongoid'


Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid_config.yml'), env_name: 'development')


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


User.create! username: 'some_name', auth_data: {}