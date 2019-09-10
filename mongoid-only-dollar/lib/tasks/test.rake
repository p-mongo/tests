task :repro => :environment do

  a=Car.create!(engines:[Engine.new(size:1)],make:'Ford')
  b=Car.create!(engines:[Engine.new(size:2),Engine.new(size:3)],make:'Datsun')

  p Car.where(make:'Ford').where('engines.size'=>1).only('engines.$').first.engines.size

end
