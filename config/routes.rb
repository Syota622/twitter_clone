# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tweets, only: [:index]
  root to: 'tweets#index'
  resources :profiles, only: %i[show edit update]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'  # 追加
  }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
