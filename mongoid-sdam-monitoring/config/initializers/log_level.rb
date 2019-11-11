Rails.application.configure do
  config.after_initialize do
    #Mongo::Logger.logger.level = Logger::DEBUG
  end
end
