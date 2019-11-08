client = Mongo::Client.new

client_encryption_options = {
  kms_providers: {
    local: { key: "ruby" * 24 }
  },
  key_vault_namespace: 'keys.keys',
}

client.crypt(client_encryption_options) do |client_encryption|

  data_key_id = BSON::Binary.new(ENV['DATA_KEY_ID'])

  encrypted = client_encryption.encrypt(
    'Hello, world!',
    data_key_id: data_key_id,
    deterministic: true,
  )

  expect(encrypted).to be_a_kind_of(BSON::Binary)

  decrypted = client_encryption.decrypt(encrypted)
  expect(decrypted).to eq('Hello, world!')

end

client.close
