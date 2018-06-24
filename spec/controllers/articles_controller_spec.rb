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

  describe 'GET #index' do
    it 'assigns specific articles'
    it 'renders the search template'
  end

  describe 'GET #show' do
    it 'assigns the requested contact to @contact'
    it 'renders the :show template'
  end

  describe 'GET #new' do
    it 'assigns a new Contact to @contact'
    it 'renders the :new template'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new contact in the database'
      it 'redirects to the home page'
    end

    context 'with invalid attributes' do
      it 'does not save the new contact in the database'
      it 're-renders the :new template'
    end
  end

  describe 'GET #edit' do
    it "assigns a new Contact to @contact"
    it 'renders the :new template'
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'saves the new contact in the database'
      it 'redirects to the home page'
    end

    context 'with invalid attributes' do
      it 'does not save the new contact in the database'
      it 're-renders the :new template'
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the article'
    it 'redirects to the home page'
  end
end
