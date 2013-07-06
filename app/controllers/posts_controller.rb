class PostsController < ApplicationController

  def show
    @posts = Post.all
  end
end
