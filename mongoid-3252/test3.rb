require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14400'],
    database: 'junk_db',
    options: {
      truncate_logs: false
    }
  }
  config.raise_not_found_error = false
end

logger = Logger.new(STDOUT)
logger.level = :debug
Mongoid.logger = logger
Mongo::Logger.logger = logger

# the big container object
class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  embeds_many :notes
end

# the template "note"
class Note
  include Mongoid::Document
  embedded_in :book, touch: false
  field :message, :type => String
end

book = Book.create!
p book.updated_at

sleep 1

book.notes << Note.new
book.save!
p book.updated_at

book.notes.first.message = 'hello'
book.save!
p book.updated_at
