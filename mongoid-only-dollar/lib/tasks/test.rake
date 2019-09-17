task :repro => :environment do

  Car.destroy_all

  a=Car.create!(engines:[Engine.new(displacement:10),Engine.new(displacement:40)],make:'Ford')
  b=Car.create!(engines:[Engine.new(displacement:20),Engine.new(displacement:30)],make:'Datsun')

  p Car.where(make:'Ford').where('engines.displacement'=>10).first.engines.first.displacement

  p Car.where(make:'Ford').where('engines.displacement'=>10).only('engines.$').first.engines.first.displacement
  p Car.where(make:'Ford').where('engines.displacement'=>{'$gte'=>10}).to_a.first.engines
  p Car.where(make:'Ford').where('engines.displacement'=>{'$gte'=>10}).only('engines.$').to_a.first.engines

  p Car.where(make:'Ford').where('engines.displacement'=>10).only('engines.$').first.engines.first.displacement

end
