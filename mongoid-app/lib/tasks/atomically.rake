task :atomically => :environment do

u = User.create!(name: "bar#{rand}")
v = Vote.create!

begin
  u.atomically(join_context: true) do
    u.atomically(join_context: false) do
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
