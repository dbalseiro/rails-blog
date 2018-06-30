# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search, :show]
  before_action :fetch_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def search
    @articles = Article.search(*search_params)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update article_params
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def fetch_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(*Article::ATTRIBUTE_WHITELIST)
  end

  def search_params
    [params[:search], params[:location]]
  end
end
