task :repro => :environment do

  Car.destroy_all

  a=Car.create!(engines:[Engine.new(displacement:1)],make:'Ford')
  b=Car.create!(engines:[Engine.new(displacement:2),Engine.new(displacement:3)],make:'Datsun')

  p Car.where(make:'Ford').where('engines.displacement'=>1).only('engines.$').first.engines.first.displacement

end
