Rails.application.routes.draw do
  root 'home#index'

  # Sessions
  resource :sessions, only: [:create, :destroy]

  # Dashbaord
  resource :dashboard, only: [:show], controller: 'dashboard'

  # Transaction related
  resource :credits, only: :create
  resource :debits, only: :create
  resource :transfers, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
