Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :update]
  resources :tags, only: [:index]
  resources :positions, only: [:index, :create]
  resources :reviews, only: [:create, :update]
  resources :votes, only: [:create]

  resources :companies, only: [:show] do
    resources :reviews, only: [:create, :update, :index] 
  end

  post 'login', to: 'users#login'
  get '/search', to: 'companies#search'
end

