require 'byebug'
require 'mongo'
#require 'mongoid'


  class CommandLogSubscriber
    include Mongo::Loggable

    def started(event)
      log_debug("#{prefix(event)} | STARTED | #{format_command(event.command)}")
    end

    def succeeded(event)
      log_debug("#{prefix(event)} | SUCCEEDED | #{event.duration}s")
    end

    def failed(event)
      log_debug("#{prefix(event)} | FAILED | #{event.message} | #{event.duration}s")
    end

    private

    def logger
      Mongo::Logger.logger
    end

    def format_command(args)
      begin
        args.inspect
      rescue Exception
        '<Unable to inspect arguments>'
      end
    end

    def format_message(message)
      format("COMMAND | %s".freeze, message)
    end

    def prefix(event)
      "#{event.address.to_s} | #{event.database_name}.#{event.command_name}"
    end
  end


  subscriber = CommandLogSubscriber.new

  Mongo::Monitoring::Global.subscribe(Mongo::Monitoring::COMMAND, subscriber)

  client = Mongo::Client.new([ '127.0.0.1:27100' ], :database => 'test' )
  client.subscribe( Mongo::Monitoring::COMMAND, subscriber )



Mongo::Logger.logger.level = 0
c = Mongo::Client.new(['127.0.0.1:27100'])

# uncomment to insert data initially
#10000.times { c['test'].insert_one(a: rand) }

def find(c)
  p c['test'].find.batch_size(10).no_cursor_timeout.first
end

10.times do
  find(c)
end

puts 'gc'

GC.start

sleep 10
puts 'done'
