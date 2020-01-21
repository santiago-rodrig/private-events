Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
