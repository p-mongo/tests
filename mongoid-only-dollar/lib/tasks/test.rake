task :repro => :environment do

  Car.destroy_all

  a=Car.create!(engines:[Engine.new(displacement:10)],make:'Ford')
  b=Car.create!(engines:[Engine.new(displacement:20),Engine.new(displacement:30)],make:'Datsun')

  p Car.where(make:'Ford').where('engines.displacement'=>10).only('engines.$').first.engines.first.displacement

end
