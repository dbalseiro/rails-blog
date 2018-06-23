class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [city, state, zipcode].join(', ')
  end
end
