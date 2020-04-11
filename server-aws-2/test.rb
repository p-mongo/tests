require 'mongo'
require 'aws-sdk-core'

=begin
bootstrap_client = Mongo::Client.new('mongodb://dev:dev@localhost:14401')
    bootstrap_client.use('$external').database.users.create(
      'arn:aws:sts::557821124784:assumed-role/authtest_user_assume_role/*',
      roles: [{role: 'root', db: 'admin'}],
      write_concern: {w: :majority, wtimeout: 5000},
    )
bootstrap_client.close
=end

Mongo::Logger.logger.level = Logger::WARN

class Tester
  def run
    client.database.command(ping: 1)
  end

  def client
    @client ||= Mongo::Client.new('mongodb://localhost:14401',
      auth_mech: :aws,
      user: ENV.fetch('AWS_ACCESS_KEY_ID'),
      password: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      auth_mech_properties: {
        aws_session_token: ENV.fetch('AWS_SESSION_TOKEN'),
      },
    )
  end
end

Tester.new.run
