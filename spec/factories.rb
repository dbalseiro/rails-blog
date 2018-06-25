# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commenter Faker::Simpsons.character
    body Faker::Simpsons.quote
    article { build(:article) }
    human true
  end

  factory :comment_without_article, parent: :comment do |c|
    c.article nil
  end

  factory :unaccepted_comment, parent: :comment do |c|
    c.human nil
  end

  factory :article do
    title 'title 1'
    text 'description'
    city 'New York'
    state 'NY'
  end

  factory :invalid_article, parent: :article do |a|
    a.title nil
  end

  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end
end
