# frozen_string_literal: true

# Articles model
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [city, state, zipcode].join(', ')
  end

  def self.search(params)
    articles = Article.all
    if params[:search].present?
      articles = articles.where('title like ?', "%#{params[:search]}%")
                 .or articles.where('text like ?', "%#{params[:search]}%")
    end

    articles = articles.near(params[:location], 20) if params[:location].present?

    articles
  end
end
