class PostsController < ApplicationController
  def index
    @post = Post.first || Post.create!
  end
end
