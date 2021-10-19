class Band
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :likes, type: Integer

  index description: 'text'

  around_save :foo, :bar

  def foo
    #byebug
    yield
  end

  def bar
    #byebug
    yield
  end

  def _after_save
    #byebug
    puts 'after save'
  end

  embeds_one :cat, cascade_callbacks: true

  around_save :as
  def as
    p 'band around save enter'
    yield
    p 'band around save exit'
  end

end
