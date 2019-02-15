require 'mongo'
require 'logger'

$logger = Logger.new(STDOUT)
$logger.level = Logger::DEBUG

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
    $logger
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

require_relative 'boot'

require "action_controller/railtie"
require "action_mailer/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MongoidExplicitId
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
