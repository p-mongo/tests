client = Mongo::Client.new

client_encryption_options = {
  kms_providers: {
    local: { key: "ruby" * 24 }
  },
  key_vault_namespace: 'keys.keys',
}

client_encryption = Mongo::ClientEncryption.new(
  client,
  client_encryption_options,
)

data_key_id = BSON::Binary.new(ENV['DATA_KEY_ID'])

encrypted = client_encryption.encrypt(
  'Hello, world!',
  key_id: data_key_id,
  algorithm: 'AEAD_AES_256_CBC_HMAC_SHA_512-Deterministic',
)

expect(encrypted).to be_a_kind_of(BSON::Binary)

decrypted = client_encryption.decrypt(encrypted)
expect(decrypted).to eq('Hello, world!')

client_encryption.close
client.close
