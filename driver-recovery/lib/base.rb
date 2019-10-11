require 'yaml'
require 'active_support/core_ext/hash'
require 'mongo'

class Base
  def initialize(options_or_path)
    if options_or_path.is_a?(String)
      options = YAML.load(File.read(options_or_path)).deep_symbolize_keys
      @config_file_path = options_or_path
    else
      options = options_or_path
    end
    @options = options
  end

  attr_reader :options

  def default_client_options
    {}
  end

  def client
    @client ||= Mongo::Client.new(options[:uri], logger: logger,
      **default_client_options.merge(**options[:client_options] || {})
    ).tap do |client|
      if options[:log_cmap]
        client.subscribe(
          Mongo::Monitoring::CONNECTION_POOL,
          Mongo::Monitoring::CmapLogSubscriber.new(logger: logger))
      end
    end
  end

  def logger
    @logger ||= Logger.new(File.open(log_path, 'w'))
  end
end
