# frozen_string_literal: true

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
    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

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
  end

  describe 'POST #create' do
    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        post :create
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

      context 'with valid attributes' do
        it 'saves the new article in the database' do
          params = { article: attributes_for(:article) }
          expect { post :create, params: params }
            .to change(Article, :count)
            .by 1
        end

        it 'redirects to the new article' do
          params = { article: attributes_for(:article) }
          post :create, params: params
          expect(response).to redirect_to Article.last
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new article in the database' do
          params = { article: attributes_for(:invalid_article) }
          expect { post :create, params: params }
            .to_not change(Article, :count)
        end

        it 're-renders the :new template' do
          params = { article: attributes_for(:invalid_article) }
          post :create, params: params
          expect(response).to render_template('new')
        end
      end
    end
  end

  describe 'GET #edit' do
    before(:context) do
      @article = create :article
    end

    after(:context) do
      Article.destroy_all
    end

    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        get :edit, params: { id: @article }
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

      it 'assigns a new article to @article' do
        get :edit, params: { id: @article }
        expect(assigns(:article)).to eq @article
      end

      it 'renders the :edit template' do
        get :edit, params: { id: @article }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'PUT #update' do
    before(:context) do
      @article = create :article
    end

    after(:context) do
      Article.destroy_all
    end

    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        get :edit, params: { id: @article }
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

      context 'with valid attributes' do
        it 'saves the article in the database' do
          attrs = attributes_for(
            :article,
            title: 'valid title',
            text: 'new description',
            city: 'Los Angeles',
            state: 'CA',
            zipcode: '90210'
          )
          params = { id: @article, article: attrs }
          put :update, params: params
          @article.reload
          expect(@article.title).to eq 'valid title'
          expect(@article.text).to eq 'new description'
          expect(@article.city).to eq 'Los Angeles'
          expect(@article.state).to eq 'CA'
          expect(@article.zipcode).to eq '90210'
        end

        it 'redirects to the article' do
          params = { id: @article, article: attributes_for(:article) }
          put :update, params: params
          expect(response).to redirect_to @article
        end
      end

      context 'with invalid attributes' do
        it 'does not save the article in the database' do
          attrs = attributes_for(
            :article,
            title: '123',
            text: 'new description',
            city: nil,
            state: nil,
            zipcode: nil
          )
          params = { id: @article, article: attrs }
          put :update, params: params
          @article.reload
          expect(@article.title).to_not eq '123'
          expect(@article.text).to_not eq 'new description'
        end

        it 're-renders the edit template' do
          params = { id: @article, article: attributes_for(:invalid_article) }
          put :update, params: params
          expect(response).to render_template('edit')
        end
      end
    end
  end

  describe 'DELETE destroy' do
    before(:context) do
      @article = create :article
    end

    after(:context) do
      Article.destroy_all
    end

    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        delete :destroy, params: { id: @article }
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

      it 'deletes the article' do
        params = { id: @article }
        expect { delete :destroy, params: params }
          .to change(Article, :count)
          .by(-1)
      end

      it 'redirects to the home page' do
        delete :destroy, params: { id: @article }
        expect(response).to redirect_to articles_url
      end
    end
  end
end
