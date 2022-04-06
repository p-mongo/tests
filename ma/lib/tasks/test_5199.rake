task :test_5199 => :environment do
  class Band
    include Mongoid::Document
    embeds_one :label
  end

  class Label
    include Mongoid::Document
    field :name, type: String
    embedded_in :band
  end

  b = Band.create!(label: Label.new(name: 'test'))

  Band.with_session do |s|
    s.start_transaction

    label = Label.new(name: "Neil")
    b.label = label

    b.reload
    puts b.label.inspect # <Label _id: 61bcab66d1327a521a5054a9, name: "Neil">

    s.commit_transaction
  end

end
