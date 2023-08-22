# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'
  devise_for :users
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
