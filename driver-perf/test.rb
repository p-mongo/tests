
require 'mongo'

Mongo::Logger.level = Logger::FATAL
client = Mongo::Client.new('mongodb://127.0.0.1:27741/test')
#client = Mongo::Client.new('mongodb://%2Ftmp%2Fmongodb-27364.sock/test')

collection = client[:people]
collection.delete_many

def watch(title:)
	ttime = nil
	_time_start = Time.now

	yield

	ttime = Time.now - _time_start   # total time
	puts "#{'%-35s' % title} -- total: #{'%.3f' % ttime} s, item time = #{'%.3f' % (ttime/@n*1000)} ms"
end

@n = 500
watch(title:"insert #{@n} (w:0)") do
	@n.times do
		doc = { name: "Steve_#{@n}", hobbies: [ 'hiking', 'tennis', 'fly fishing' ] }
		result = collection.with(:write => { :w => 0 }).insert_one(doc)
	end
end
collection.delete_many
watch(title:"insert #{@n} (w:1)") do
	@n.times do
		doc = { name: "Steve_#{@n}", hobbies: [ 'hiking', 'tennis', 'fly fishing' ] }
		result = collection.insert_one(doc)
	end
end

watch(title:"#{@n} times find all") do
	@n.times do
		collection.find.to_a.to_s
	end
end

watch(title:"#{@n} times find first (full)") do
	@n.times do
		collection.find.first.to_s
	end
end

watch(title:"#{@n} times find first (only name)") do
	@n.times do
		collection.find({}, projection:{name:1, _id:0}).first
	end
end

watch(title:"#{@n} times count()") do
	@n.times do
		collection.count()
	end
end
