task :atomically => :environment do

#Mongo::Logger.logger = Logger.new(STDOUT)
#Mongo::Logger.logger.level = Logger::DEBUG


# --

u = User.create!(name: "bar#{rand}")
v = Vote.create!

begin
  puts 'start'
  v.atomically(join_context: true) do
    v.atomically(join_context: true) do
      u.set(name: "foo#{rand}")
    end
    u.set(city: "city")
    v.set(message: 'hai')
    #raise 'uh oh'
  end
rescue => e
  p e
  p v
  p u
end

v.reload
u.reload

puts '--'
p v
p u

end
