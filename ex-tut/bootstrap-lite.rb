require 'mongo'
require 'ruby-progressbar'
require 'base64'

Mongo::Logger.logger.level = Logger::INFO
client = Mongo::Client.new(['localhost:14420'], database: 'load')

collection = client['data']
collection.drop

# 10 million total documents with:
# - an indexed counter
# - a non-indexed counter
# - an indexed text field
# - a non-indexed text field

ROUNDS = 100
BATCH_SIZE = 100

bar = ProgressBar.create(total: ROUNDS, format: '%c / %C |%B| %p%% %e')

i = 0
ROUNDS.times do
  docs = 1.upto(BATCH_SIZE).map do
    i += 1
    text_length = 10 + (rand * 90).to_i
    {
      counter: i,
      slow_counter: i,
      text: Base64.encode64(SecureRandom.random_bytes(100))[0...text_length],
      slow_text: Base64.encode64(SecureRandom.random_bytes(100))[0...text_length],
    }
  end

  collection.insert_many(docs)
  bar.increment
end

collection.indexes.create_one(counter: 1)
collection.indexes.create_one(text: 1)
