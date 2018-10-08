Rails.application.routes.draw do

  use_doorkeeper do
    skip_controllers :appointments, :schedules, :clients, :professionals, :users
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    #omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
  }

  UUID_regex = /([a-z0-9]){8}-([a-z0-9]){4}-([a-z0-9]){4}-([a-z0-9]){4}-([a-z0-9]){12}/ unless defined? UUID_regex
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    namespace :api, defaults: { format: :json }, constraints: { id: UUID_regex } do
      namespace :v1 do
        resource :sessions, only: [ :create ]
        resource :users, only: [ :create, :update, :destroy ]
        resource :professionals, only: [ :create, :update, :destroy ]
        resource :clients, only: [ :create, :update, :destroy ]
        resource :appointments, only: [ :create, :update, :destroy ]
      end
    end
  end

  resources :appointments
  resources :schedules
  resources :clients
  resources :professionals
  #resources :users

  root to: "professionals#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
