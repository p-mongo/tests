require 'mongo'

class CommandLogSubscriber
  include Mongo::Loggable

  def started(event)
    p event.command
    log_debug("#{prefix(event)} | STARTED | #{format_command(event.command)}")
  end

  def succeeded(event)
    p event.reply
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


class HeartbeatLogSubscriber
  include Mongo::Loggable

  def started(event)
  p event
    log_debug("#{event.address} | STARTED")
  end

  def succeeded(event)
  p event
    log_debug("#{event.address} | SUCCEEDED | #{event.duration}s")
  end

  def failed(event)
    log_debug("#{event.address} | FAILED | #{event.error.class}: #{event.error.message} | #{event.duration}s")
  end

  private

  def logger
    Mongo::Logger.logger
  end

  def format_message(message)
    format("HEARTBEAT | %s".freeze, message)
  end
end

subscriber = CommandLogSubscriber.new

#Mongo::Monitoring::Global.subscribe(Mongo::Monitoring::COMMAND, subscriber)




subscriber = HeartbeatLogSubscriber.new

Mongo::Monitoring::Global.subscribe(Mongo::Monitoring::SERVER_HEARTBEAT, subscriber)


a = Mongo::Client.new('mongodb://dev:dev@localhost:14430')
#a.subscribe(Mongo::Monitoring::COMMAND, subscriber)
a.command(create: 'foo')
