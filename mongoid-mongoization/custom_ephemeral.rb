require 'byebug'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14400'],
    database: 'junk_db',
    options: {
      truncate_logs: false
    }
  }
  config.raise_not_found_error = false
end

logger = Logger.new(STDOUT)
logger.level = :debug
Mongoid.logger = logger
Mongo::Logger.logger = logger

class ColorField
  def self.mongoize(value)
    case value
    when 'black'
      0
    when 'white'
      1
    else
      raise 'Bad value for mongoize'
    end
  end

  def self.demongoize(value)
    case value
    when 0
      'black'
    when 1
      'white'
    else
      raise 'Bad value for demongoize'
    end
  end
end

class Entry
  include Mongoid::Document

  field :color, type: ColorField
end

#byebug
entry = Entry.new(color: 'black')
p entry.attributes
  p entry.color
entry.save!

entry = Entry.find(entry.id)
p entry.attributes
p entry.color

__END__

Result - Mongoid 7.4.0:

serene2% be ruby custom_ephemeral.rb
Calling `DidYouMean::SPELL_CHECKERS.merge!(error_name => spell_checker)' has been deprecated. Please call `DidYouMean.correct_error(error_name, spell_checker)' instead.
Calling `DidYouMean::SPELL_CHECKERS.merge!(error_name => spell_checker)' has been deprecated. Please call `DidYouMean.correct_error(error_name, spell_checker)' instead.
{"_id"=>BSON::ObjectId('62beabe4a15d5d14fe35b11e'), "color"=>0}
"black"
D, [2022-07-01T04:10:12.585809 #5374] DEBUG -- : MONGODB | Topology type 'unknown' initializing.
D, [2022-07-01T04:10:12.585978 #5374] DEBUG -- : MONGODB | There was a change in the members of the 'Unknown' topology.
D, [2022-07-01T04:10:12.586075 #5374] DEBUG -- : MONGODB | Server localhost:14400 initializing.
D, [2022-07-01T04:10:12.586191 #5374] DEBUG -- : MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=Unknown[localhost:14400] servers=[#<Server address=localhost:14400 UNKNOWN>]>
D, [2022-07-01T04:10:12.587541 #5374] DEBUG -- : MONGODB | Server description for localhost:14400 changed from 'unknown' to 'standalone'.
D, [2022-07-01T04:10:12.587773 #5374] DEBUG -- : MONGODB | Topology type 'Unknown' changed to type 'Single'.
D, [2022-07-01T04:10:12.589572 #5374] DEBUG -- : MONGODB | localhost:14400 req:6 conn:1:1 sconn:712 | junk_db.insert | STARTED | {"insert"=>"entries", "ordered"=>true, "documents"=>[{"_id"=>BSON::ObjectId('62beabe4a15d5d14fe35b11e'), "color"=>0}], "$db"=>"junk_db", "lsid"=>{"id"=><BSON::Binary:0x2020 type=uuid data=0x51965005d42841ce...>}}
D, [2022-07-01T04:10:12.589899 #5374] DEBUG -- : MONGODB | localhost:14400 req:6 | junk_db.insert | SUCCEEDED | 0.000s
D, [2022-07-01T04:10:12.590783 #5374] DEBUG -- : MONGODB | localhost:14400 req:7 conn:1:1 sconn:712 | junk_db.find | STARTED | {"find"=>"entries", "filter"=>{"_id"=>BSON::ObjectId('62beabe4a15d5d14fe35b11e')}, "$db"=>"junk_db", "lsid"=>{"id"=><BSON::Binary:0x2020 type=uuid data=0x51965005d42841ce...>}}
D, [2022-07-01T04:10:12.591113 #5374] DEBUG -- : MONGODB | localhost:14400 req:7 | junk_db.find | SUCCEEDED | 0.000s
{"_id"=>BSON::ObjectId('62beabe4a15d5d14fe35b11e'), "color"=>0}
"black"
