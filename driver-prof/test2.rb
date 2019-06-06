gem 'mongo', '= 2.1.2'

require 'mongo'

require 'ruby-prof'

 

Mongo::Logger.level = Logger::FATAL

client = Mongo::Client.new('mongodb://127.0.0.1:27741/test', :connect => :direct, min_pool_size:1)

 

result = RubyProf.profile do


    client.cluster.next_primary


end

 

printer = RubyProf::CallStackPrinter.new(result)

printer.print(File.open 'profiling/result.html', 'wb')

