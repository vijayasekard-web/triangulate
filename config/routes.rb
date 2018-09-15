Rails.application.routes.draw do
  resources :appointments
  resources :schedules
  resources :clients
  resources :professionals
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
