require 'mongo'
require 'byebug'

Mongo::Logger.logger.level = 1

client = Mongo::Client.new(['localhost:14240', 'localhost:14241']).use('xxx').with(
  read_concern: {level: :majority}, write_concern: {w: :majority})
db1 = client[:db1]

loop do
  15.times do
    db1.insert_many([{a: rand}]*5)
  end

  check = rand >= 0.9

  if check
    db1.database.drop
  end

  db1.insert_one(a: 1)

  if check
    v = db1.count_documents
    if v != 1
      p v
      #byebug
      1
      loop do
        v = db1.count_documents
        if v != 1
          p v
          sleep 1
        else
          byebug
          1
        end
      end
    end
  end

  print('.')
end
