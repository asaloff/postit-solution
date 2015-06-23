class PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :edit, :vote]
  before_action :require_user, except: [:index, :show, :vote]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash["notice"] = "The post has been created"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash["notice"] = "The post has been updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(vote: params[:up_vote?], creator: current_user, voteable: @post)
    
    if @vote.valid?
      flash['notice'] = "You voted!"
    else
      flash['error'] = "You already voted."
    end

    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def all_categories
    Category.all
  end
end
