# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_article

  def create
    comment = @article.comments.build(comment_params)
    if comment.save
      redirect_to @article
    else
      add_errors_from comment
      render 'articles/show'
    end
  end

  def destroy
    comment = @article.comments.find params[:id]
    comment.destroy
    redirect_to @article
  end

  private

  def fetch_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(*Comment::ATTRIBUTE_WHITELIST)
  end

  def add_errors_from(record)
    record.errors.full_messages.each do |msg|
      @article.errors[:base] << msg
    end
  end
end
