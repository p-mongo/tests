```
serene% ruby test.rb
7.0.12
2.14.0
#<Comment _id: 6080e37a2c97a63db8a4cd83, article_id: nil>
Traceback (most recent call last):
	16: from test.rb:40:in `<main>'
	15: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/persistable/creatable.rb:146:in `create'
	14: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/threaded/lifecycle.rb:161:in `_creating'
	13: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/persistable/creatable.rb:150:in `block in create'
	12: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/persistable/creatable.rb:150:in `new'
	11: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/document.rb:116:in `initialize'
	10: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/threaded/lifecycle.rb:89:in `_building'
	 9: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/document.rb:121:in `block in initialize'
	 8: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/attributes/processing.rb:23:in `process_attributes'
	 7: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/attributes/processing.rb:23:in `each_pair'
	 6: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/attributes/processing.rb:25:in `block in process_attributes'
	 5: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/attributes/processing.rb:100:in `process_attribute'
	 4: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/association/accessors.rb:279:in `block (2 levels) in define_ids_setter!'
	 3: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/findable.rb:94:in `find'
	 2: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/criteria/findable.rb:41:in `find'
	 1: from /home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/criteria/findable.rb:21:in `execute_or_raise'
/home/w/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/mongoid-7.0.12/lib/mongoid/criteria.rb:466:in `check_for_missing_documents!':  (Mongoid::Errors::DocumentNotFound)
message:
  Document(s) not found for class Comment with id(s) 6080e37a2c97a63db8a4cd83.
summary:
  When calling Comment.find with an id or array of ids, each parameter must match a document in the database or this error will be raised. The search was for the id(s): 6080e37a2c97a63db8a4cd83 ... (1 total) and the following ids were not found: 6080e37a2c97a63db8a4cd83.
resolution:
  Search for an id that is in the database or set the Mongoid.raise_not_found_error configuration option to false, which will cause a nil to be returned instead of raising this error when searching for a single id, or only the matched documents when searching for multiples.
```
