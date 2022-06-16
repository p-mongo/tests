  class Zombie
    include Mongoid::Document

    belongs_to :country

    # Shards by country_id.
    shard_key country: 1

    # The collection must also have an index that starts with the shard key.
    index country: 1
  end
