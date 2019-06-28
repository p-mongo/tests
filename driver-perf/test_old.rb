require 'mongo'

client = Mongo::MongoClient.new 'localhost', 27741
db = client.db 'test'

collection = db[:people]
collection.remove

def watch(title:nil)
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
		result = collection.insert(doc, { :w => 0 })
	end
end
collection.remove
watch(title:"insert #{@n} (w:1)") do
	@n.times do
		doc = { name: "Steve_#{@n}", hobbies: [ 'hiking', 'tennis', 'fly fishing' ] }
		result = collection.insert(doc)
	end
end

watch(title:"#{@n} times find all") do
	@n.times do
		collection.find.to_a.to_s
	end
end

watch(title:"#{@n} times find first (full)") do
	@n.times do
		collection.find_one.to_s
	end
end

watch(title:"#{@n} times find first (only name)") do
	@n.times do
		collection.find_one({}, fields:{name:1, _id:0})
	end
end

watch(title:"#{@n} times count()") do
	@n.times do
		collection.count()
	end
end






