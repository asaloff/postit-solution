class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      @post.comments << @comment
      flash["notice"] = "Comment was created"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:up_vote?])

    if @vote.valid?
      flash['notice'] = 'You Voted!'
    else
      flash['error'] = 'You already voted on that'
    end
    redirect_to :back
  end
end