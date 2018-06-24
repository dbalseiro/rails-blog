# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = true
end

RSpec.describe Article, type: :model do
  describe '.full_article' do
    let(:article) { Article.new }
    context 'when the article is empty' do
      it 'returns an empty address' do
        expect(article.full_address).to eq ', , '
      end
    end

    context 'when the article has data' do
      it 'returns the address' do
        article.city = 'ny'
        expect(article.full_address).to eq 'ny, , '
      end

      it 'returns the full address' do
        article.city = 'ny'
        article.state = 'new york'
        article.zipcode = '90210'
        expect(article.full_address).to eq 'ny, new york, 90210'
      end
    end
  end

  describe '.search' do
    context 'when there are no articles' do
      it 'returns an empty list'
    end

    context 'when there are many articles' do
      context 'and the criteria is empty' do
        it 'returns all the articles'
      end

      context 'and the criteria is location' do
        it 'returns the article with the nearest location'
      end

      context 'and the criteria is text' do
        it 'returns the article that matches the text'
        it 'returns the article that matches the title'
      end

      context 'and the criteria is for both location and text' do
        it 'returns the article that matches both criteria'
      end

      context 'and the criteria does not match any article' do
        it 'returnd an empty list'
      end
    end
  end
end
