# frozen_string_literal: true

# Controller for the comments
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find params[:article_id]
    comment = @article.comments.new comment_params
    if comment.valid?
      comment.save
      redirect_to @article
    else
      add_errors_from comment
      @article.comments.delete comment
      render 'articles/show'
    end
  end

  def destroy
    @article = Article.find params[:article_id]
    comment = @article.comments.find params[:id]
    comment.destroy
    redirect_to @article
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:commenter, :body, :human)
  end

  def add_errors_from(record)
    record.errors.full_messages.each do |msg|
      @article.errors[:base] << msg
    end
  end
end
