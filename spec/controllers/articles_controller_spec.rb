require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'assigns articles' do
      article = create :article
      get :index
      expect(assigns(:articles)).to eq [article]
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #search' do
    it 'assigns specific articles' do
      article = create :article
      params = { location: 'Manhattan' }
      get :search, params: params
      expect(assigns(:articles)).to eq [article]
    end

    it 'renders the search template' do
      get :search
      expect(response).to render_template('search')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested article to @article' do
      article = create :article
      get :show, params: { id: article }
      expect(assigns(:article)).to eq article
    end

    it 'renders the :show template' do
      article = create :article
      get :show, params: { id: article }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'assigns a new article to @article' do
      get :new
      article = assigns :article
      expect(article).not_to be nil
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new article in the database'
      it 'redirects to the home page'
    end

    context 'with invalid attributes' do
      it 'does not save the new article in the database'
      it 're-renders the :new template'
    end
  end

  describe 'GET #edit' do
    it 'assigns a new article to @article'
    it 'renders the :new template'
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'saves the new article in the database'
      it 'redirects to the home page'
    end

    context 'with invalid attributes' do
      it 'does not save the new article in the database'
      it 're-renders the :new template'
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the article'
    it 'redirects to the home page'
  end
end
