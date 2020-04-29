require 'byebug'
require 'faraday'
require 'faraday/detailed_logger'
require 'faraday/digestauth'

class Tester
  def test
    resp = connection.get('groups')
    puts resp.body
    p '-----------'
    resp = connection.get('groups')
    puts resp.body
  end

  def connection
    @connection ||= Faraday.new("https://cloud.mongodb.com/api/atlas/v1.0/") do |f|
      username = ENV['MCLI_PUBLIC_API_KEY']
      password = ENV['MCLI_PRIVATE_API_KEY']

      f.request :url_encoded
      f.request :digest, username, password
      f.response :detailed_logger
      if ENV['JIRA_ACCESS_TOKEN']
        f.request :oauthenticator_signer, signing_options
      end
      f.adapter Faraday.default_adapter
      f.headers['user-agent'] = 'EvergreenRubyClient'
      if false && username && password
        f.basic_auth(username, password)
      end
    end
  end
end

Tester.new.test
