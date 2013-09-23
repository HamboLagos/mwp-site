class PostsController < ApplicationController
  include SessionsHelper

  before_action :administrative_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @current_athlete = current_athlete
    @posts = Post.all.sort { |a,b| b.updated_at <=> a.updated_at } # reverse chronological order
  end

  def new
    @athlete = current_athlete
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.athlete_id = params[:athlete_id]
    if @post.save
      flash[:notice] = 'Your Post has been saved'
      redirect_to root_path
    else
      @athlete = current_athlete
      render 'new'
    end
  end

  def edit
    if admin?
      @athlete = current_athlete
      @post = Post.find(params[:id])
    else
      flash['error'] = 'You must have administrative privelages to edit a post'
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.athlete_id = params[:athlete_id]
    if @post.update(post_params)
      flash[:notice] = 'Your Post has been saved'
      redirect_to root_path
    else
      @athlete = current_athlete
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
