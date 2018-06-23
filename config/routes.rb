# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :articles do
    resources :comments

    collection do
      get 'search'
    end
  end

  root 'welcome#index'
end
