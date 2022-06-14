# automatic encryption where the field in db is not encrypted

require 'mongo'


# Configure the client for automatic encryption
client = Mongo::Client.new(
  ['localhost:16020'],
)

collection = client.use('encryption_db')['encryption_coll']
collection.drop # Make sure there is no data in the collection

# The string "sensitive data" will be encrypted and stored in the database
# as ciphertext
collection.insert_one(encrypted_field: 234, a: 1)

#####################################
# Step 1: Create a local master key #
#####################################

# A local master key is a 96-byte binary blob.
local_master_key = SecureRandom.random_bytes(96)
# => "\xB2\xBE\x8EN\xD4\x14\xC2\x13\xC3..."

#############################
# Step 2: Create a data key #
#############################

kms_providers = {
  local: {
    key: local_master_key
  }
}

# The key vault client is a Mongo::Client instance connected to the collection
# that will store your data keys.
key_vault_client = Mongo::Client.new(['localhost:16020'])

# Use an instance of Mongo::ClientEncryption to create a new data key
client_encryption = Mongo::ClientEncryption.new(
  key_vault_client,
  key_vault_namespace: 'admin.datakeys',
  kms_providers: kms_providers
)

data_key_id = client_encryption.create_data_key('local')
# => <BSON::Binary... type=ciphertext...>

#######################################################
# Step 3: Configure Mongo::Client for auto-encryption #
#######################################################

# Create a schema map, which tells the Mongo::Client which fields to encrypt
schema_map = {
  'encryption_db.encryption_coll': {
    properties: {
      'encrypted_field' => {
        encrypt: {
          keyId: [data_key_id],
          bsonType: "int",
          algorithm: "AEAD_AES_256_CBC_HMAC_SHA_512-Deterministic"
        }
      }
    },
    bsonType: "object"
  }
}

# Configure the client for automatic encryption
client = Mongo::Client.new(
  ['localhost:16020'],
  auto_encryption_options: {
    key_vault_namespace: 'admin.datakeys',
    kms_providers: kms_providers,
    schema_map: schema_map
  }
)

collection = client.use('encryption_db')['encryption_coll']
#collection.drop # Make sure there is no data in the collection

# The string "sensitive data" will be encrypted and stored in the database
# as ciphertext
collection.insert_one(encrypted_field: 235, a: 2)

# The data is decrypted before being returned to the user
p collection.find(encrypted_field: 234).first['encrypted_field']
# => "sensitive data"

# A client with no auto_encryption_options is unable to decrypt the data
client_no_encryption = Mongo::Client.new(['localhost:16020'])
client_no_encryption.use('encryption_db')['encryption_coll'].find.first['encrypted_field']
# => <BSON::Binary... type=ciphertext...>
