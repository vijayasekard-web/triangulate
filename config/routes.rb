Rails.application.routes.draw do

devise_for :users, controllers: { sessions: 'users/sessions' }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  resources :appointments
  resources :schedules
  resources :clients
  resources :professionals
  resources :users

  root to: "professionals#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
