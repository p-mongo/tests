```
serene% ruby test.rb 
Traceback (most recent call last):
	38: from test.rb:10:in `<main>'
	37: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/collection.rb:561:in `insert_one'
	36: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/client.rb:1023:in `with_session'
	35: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/collection.rb:572:in `block in insert_one'
	34: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/retryable.rb:209:in `write_with_retry'
	33: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/retryable.rb:300:in `legacy_write_with_retry'
	32: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/collection.rb:583:in `block (2 levels) in insert_one'
	31: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/write.rb:40:in `execute'
	30: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server.rb:429:in `with_connection'
	29: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_pool.rb:590:in `with_connection'
	28: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/write.rb:50:in `block in execute'
	27: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/executable_no_validate.rb:25:in `execute'
	26: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/executable.rb:27:in `do_execute'
	25: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/response_handling.rb:82:in `unpin_maybe'
	24: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/executable.rb:28:in `block in do_execute'
	23: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/response_handling.rb:43:in `add_error_labels'
	22: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/executable.rb:29:in `block (2 levels) in do_execute'
	21: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/response_handling.rb:96:in `add_server_diagnostics'
	20: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/executable.rb:30:in `block (3 levels) in do_execute'
	19: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/insert/op_msg.rb:35:in `get_result'
	18: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/operation/shared/executable.rb:64:in `dispatch_message'
	17: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_base.rb:145:in `dispatch'
	16: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection.rb:299:in `deliver'
	15: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection.rb:306:in `handle_errors'
	14: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection.rb:300:in `block in deliver'
	13: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_base.rb:155:in `deliver'
	12: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_common.rb:124:in `ensure_connected'
	11: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_base.rb:165:in `block in deliver'
	10: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_common.rb:84:in `add_server_diagnostics'
	 9: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/server/connection_base.rb:168:in `block (2 levels) in deliver'
	 8: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/protocol/message.rb:259:in `deserialize'
	 7: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/protocol/message.rb:259:in `each'
	 6: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/protocol/message.rb:263:in `block in deserialize'
	 5: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/protocol/message.rb:435:in `deserialize_field'
	 4: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/protocol/serializers.rb:219:in `deserialize'
	 3: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/protocol/serializers.rb:282:in `deserialize'
	 2: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongo-2.14.0/lib/mongo/dbref.rb:110:in `from_bson'
	 1: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/bson-4.12.0/lib/bson/hash.rb:111:in `from_bson'
/home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/bson-4.12.0/lib/bson/hash.rb:111:in `get_hash': String E11000 duplicate key error collection: admin.foo index: k_1 dup key: { k: "(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□�..." } is not valid UTF-8: bogus high bits for continuation byte (EncodingError)
```

Error message string:

E11000 duplicate key error collection: admin.foo index: k_1 dup key: { k: "(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻(╯°□�..." }
