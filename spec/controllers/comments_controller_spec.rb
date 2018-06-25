# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @article = create :article
    @comment = @article.comments.create attributes_for(:comment)
  end

  after(:each) do
    Article.destroy_all
  end

  describe 'POST #create' do
    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        post :create, params: { article_id: @article }
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

      context 'with valid attributes' do
        it 'saves the new comment in the database' do
          params = { article_id: @article, comment: attributes_for(:comment) }
          expect { post :create, params: params }
            .to change(@article.comments, :count)
            .by 1
        end

        it 'redirects to the article' do
          params = { article_id: @article, comment: attributes_for(:comment) }
          post :create, params: params
          expect(response).to redirect_to @article
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new comment in the database' do
          params = { article_id: @article,
                     comment: attributes_for(:unaccepted_comment) }
          expect { post :create, params: params }
            .to_not change(@article.comments, :count)
        end

        it 're-renders the template' do
          params = { article_id: @article,
                     comment: attributes_for(:unaccepted_comment) }
          post :create, params: params
          expect(response).to render_template('articles/show')
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when the user is not logged in' do
      it 'redirects to the sign in page' do
        delete :destroy, params: { article_id: @article, id: @comment }
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when the user is logged in' do
      login_user

      it 'deletes the article' do
        params = { article_id: @article, id: @comment }
        expect { delete :destroy, params: params }
          .to change(@article.comments, :count)
          .by(-1)
      end

      it 'redirects to the home page' do
        delete :destroy, params: { article_id: @article, id: @comment }
        expect(response).to redirect_to @article
      end
    end
  end
end
