# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tweets#index'

  resources :tweets, only: %i[index show new create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
    resource :retweet, only: %i[create destroy]
    resource :bookmark, only: %i[create destroy]
  end

  resources :profiles, only: %i[show edit update]
  resources :bookmarks, only: [:index]

  resources :messages, only: %i[index show create]
  resources :notifications, only: [:index]

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'  # 追加
  }

  resources :users do
    resource :follow_relation, only: %i[create destroy], module: :users
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
