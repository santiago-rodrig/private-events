Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    post 'invite', on: :member, to: 'users#invite'
    post 'attend', on: :member, to: 'users#attend'
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#login'
  delete 'logout', to: 'sessions#logout'
  resources :events, only: [:new, :create, :show, :index]
  root 'events#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
