require 'mongo'
require 'aws-sdk-core'

sts_client = Aws::STS::Client.new
p sts_client.get_caller_identity

Mongo::Logger.logger.level = Logger::WARN

class Tester
  def run
    puts
    puts client.cluster.summary
    puts

    client.cluster.next_primary.with_connection do |conn|
      payload = {
        r: BSON::Binary.new('0'*32),
        p: 110,
      }
      selector = {
        saslStart: 1,
        autoAuthorize: 1,
        '$db' => '$external',
        mechanism: 'MONGODB-AWS',
        payload: BSON::Binary.new(payload.to_bson.to_s),
      }
      reply = dispatch(selector, conn)
      p reply
      doc = reply.documents.first
      resp = Hash.from_bson(BSON::ByteBuffer.new(doc[:payload].data))
      p resp
      server_nonce = resp[:s].data[32..64]

      request = Mongo::Auth::Aws::Request.new(
        access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
        session_token: ENV.fetch('AWS_SESSION_TOKEN'),
        host: resp[:h],
        server_nonce: server_nonce,
      )

      auth = request.authorization
      puts
      puts auth
      puts
      payload = {
        a: 'AWS4-HMAC-SHA256 \
Credential=ASIAYDYF24CYGCSCSRHQ/20200411/us-east-1/sts/aws4_request, \
SignedHeaders=content-length;content-type;host;x-amz-date;x-mongodb-gs2-cb-flag;x-mongodb-server-nonce, \
Signature=ec792fffff0a39bbaec8c043999d0dd63e401720be860a1496d968ab82dd817b',
        d: 'dummy',
      }
      selector = {
        saslContinue: 1,
        '$db' => '$external',
        conversationId: doc[:conversationId],
        payload: BSON::Binary.new(payload.to_bson.to_s),
      }
      reply = dispatch(selector, conn)
      p reply
    end
  end

  def dispatch(selector, conn)
    msg = Mongo::Protocol::Msg.new([], {}, selector)
    reply = conn.dispatch([msg])
  end

  def client
    @client ||= Mongo::Client.new('mongodb://dev:dev@localhost:14401')
  end
end

Tester.new.run
