# frozen_string_literal: true

Rails.application.routes.draw do
  root 'event#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home
  resources :user
  resources :event do
    resources :attendance
  end
end
