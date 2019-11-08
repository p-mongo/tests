client = Mongo::Client.new

client_encryption_options = {
  kms_providers: {
    local: { key: "ruby" * 24 }
  },
  key_vault_namespace: 'keys.keys',
  # Defaults for data key id & encryption mode
  # Key is accepted as a string
  data_key_id: ENV['DATA_KEY_ID'],
  deterministic: false,
}

client.crypt(client_encryption_options) do |client_encryption|

  # Probabilistic
  encrypted = client_encryption.encrypt(
    'Hello, world!',
  )

  # Deterministic
  encrypted = client_encryption.encrypt(
    'Hello, world!',
    # Key & encryption mode can be overridden
    deterministic: true,
  )

  expect(encrypted).to be_a_kind_of(BSON::Binary)

  decrypted = client_encryption.decrypt(encrypted)
  expect(decrypted).to eq('Hello, world!')

end

client.close
