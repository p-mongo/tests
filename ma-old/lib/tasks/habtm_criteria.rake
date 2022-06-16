task :test_habtm_criteria => :environment do

class User

  include Mongoid::Document

  has_many :calendars

end



class Calendar

  include Mongoid::Document

  belongs_to :user

end



admin = User.create!


p admin.calendars.class
p admin.calendars

end
