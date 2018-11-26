class FooController < ApplicationController
  def index
    1000.times do
      Bar.count
    end
    @a=1
  end
end
