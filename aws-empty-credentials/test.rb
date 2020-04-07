require 'aws-sdk-core'

credentials = Aws::Credentials.new('', '')
client = Aws::STS::Client.new(credentials: credentials, region: 'us-east-2')
p client.get_caller_identity
