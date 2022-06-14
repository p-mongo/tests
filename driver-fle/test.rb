require 'mongo'

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
key_vault_client = Mongo::Client.new(['localhost:27017'])

# Use an instance of Mongo::ClientEncryption to create a new data key
client_encryption = Mongo::ClientEncryption.new(
  key_vault_client,
  key_vault_namespace: 'admin.datakeys',
  kms_providers: kms_providers
)

data_key_id = client_encryption.create_data_key('local')
# => <BSON::Binary... type=ciphertext...>

#####################################################
# Step 3: Encrypt a string with explicit encryption #
#####################################################

# The value to encrypt
value = 'sensitive data'

# Encrypt the value
encrypted_value = client_encryption.encrypt(
  'sensitive data',
  {
    key_id: data_key_id,
    algorithm: "AEAD_AES_256_CBC_HMAC_SHA_512-Deterministic"
  }
)

# Create the client you will use to read and write the data to MongoDB
client = Mongo::Client.new(['localhost:27017'])
collection = client.use('encryption_db')['encryption_coll']
collection.drop # Make sure there is no data in the collection

# Insert the encrypted value into the collection
collection.insert_one(encrypted_field: encrypted_value)

# Use the client to read the encrypted value from the database, then
# use the ClientEncryption object to decrypt it
find_result = collection.find(encrypted_field: encrypted_value).first['encrypted_field']
# => <BSON::Binary...> (the find result is encrypted)

unencrypted_result = client_encryption.decrypt(find_result)
# => "sensitive data"
