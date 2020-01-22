class AddDefaultAdmin < Mongoid::Migration
  def self.up
    Admin.create(email: 'test@test.com', password: 'password')
  end

  def self.down
  end
end
