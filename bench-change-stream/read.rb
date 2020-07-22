require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'test')
coll = client['bench']

count = 0
start_time = last_time = Time.now
begin
  coll.watch.to_enum.each do |doc|
    count += 1
    if count % 10000 == 0
      new_time = Time.now
      delta = new_time - last_time
      last_time = new_time
      puts('%d doc/s' % (10000 / delta))
    end
  end
ensure
  delta = Time.now - start_time
  puts('average: %d doc/s' % (count / delta))
end
