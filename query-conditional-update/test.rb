require 'mongo'

client = Mongo::Client.new(['localhost:14400'])

coll = client['coll']

coll.delete_many
10.times do |i|
  coll.insert_one(foo: i, in_use: 0)
end

status = {}
lock = Mutex.new

threads = 20.times.map do |i|
  Thread.new do
    client = Mongo::Client.new(['localhost:14400'])
    loop do
      doc = coll.find(in_use: 0).first
      if doc.nil?
        next
      end

      foo = doc['foo']

      rv = coll.update_one({foo: foo, in_use: 0}, '$set' => {in_use: 1})
      if rv.modified_count == 1
        puts "Thread #{i} got #{foo}"
      else
        next
      end

      lock.synchronize do
        if other_thread = status[foo]
          puts "Doc #{foo} is already being processed by #{other_thread}, retrieved by #{i}"
          next
        end
        status[foo] = i
      end

      sleep rand

      lock.synchronize do
        status.delete(foo)
      end

      coll.update_one({foo: foo}, '$set' => {in_use: 0})
    end
  end
end

threads.map(&:join)
